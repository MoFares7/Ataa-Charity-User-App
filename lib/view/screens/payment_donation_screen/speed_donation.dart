// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_null_comparison

import 'dart:convert';

import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/data/content/donation_service.dart';
import 'package:charity_management_system/data/model/speed_donation_model.dart';
import 'package:charity_management_system/view/controllers/payment_controllers.dart';
import 'package:charity_management_system/view/widgets/main_buttom.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';

import '../../../configs/helpers.dart';
import '../../../configs/size.dart';
import '../../../data/model/donation_ca.dart';


final paymentController = Get.put(PaymentController());

Future<dynamic> SpeedDonationScreen({
  required BuildContext context,
  required Function(String) onPayPressed,
  required Function(String) onPayPressed1,
  required Function(String) onPayPressed2,
}) async {
  checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      check(context);
    }
  }

  Map<String, dynamic>? paymentIntentData;
  TextEditingController controllerNameDonation = TextEditingController();
  TextEditingController controllerAmountDonation = TextEditingController();
  TextEditingController controllerPhoneNumberDonation = TextEditingController();
  final formKey = GlobalKey<FormState>();

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      // print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51HMhFAA3qSFwIzsU4zELawchbaxbBbLa4yHs4Lvj2DpvY7WMMqat80EjYfqbX4fAY3PgGEBlAIRbjdD6UA8b93xP00aVSvGJvo',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      //print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  Future<void> makePayment({
    required String value,
    required String currency,
    required VoidCallback onSuccess,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(
          value, currency); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: false,
                  style: ThemeMode.light,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      displayPaymentSheet() async {
        try {
          await Stripe.instance
              .presentPaymentSheet(
                  // ignore: deprecated_member_use
                  parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          ))
              .then((newValue) {
            print('payment intent' + paymentIntentData!['amount'].toString());

            // send donation operation to server
            onSuccess();
            print('payment dddddddddddddddddddddddd' +
                paymentIntentData!['amount'].toString());

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("paid successfully")));

            paymentIntentData = null;
          }).onError((error, stackTrace) {
            print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
          });
        } on StripeException catch (e) {
          print('Exception/DISPLAYPAYMENTSHEET==> $e');
          showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                    content: Text("Cancelled "),
                  ));
        } catch (e) {
          print('$e');
        }
      }

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom / 2),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Form(
                key: formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    tr('Speed Donation'),
                    style:
                        TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormSpeedDonation(
                      hintText: tr('Enter the name donation'),
                      controller: controllerNameDonation,
                      validator: (content) {
                        if (content == null || content.isEmpty) {
                          return tr('The field is required');
                        }
                        return null;
                      },
                      inputType: TextInputType.name),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormSpeedDonation(
                      // formKey: _formKey,
                      hintText: tr('Enter the donation amount'),
                      controller: controllerAmountDonation,
                      validator: (content) {
                        if (content == null || content.isEmpty) {
                          return tr('The field is required');
                        }
                        return null;
                      },
                      inputType: TextInputType.number),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  TextFormNormail(
                      // formKey: _formKey,
                      hintText: tr('Enter the number donation') +
                          ' ' +
                          '(' +
                          tr('Optional') +
                          ')',
                      controller: controllerPhoneNumberDonation,
                      inputType: TextInputType.number),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    tr('Make sure that your donation will go to the most needy cases'),
                    style: TextStyle(
                      fontSize: 8.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 5.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            // color: AppColors.cardLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/icons/cash1.svg',
                            fit: BoxFit.cover,
                            height: 40.sp,
                          )),
                        ),
                        Container(
                          height: 5.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            // color: AppColors.cardLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/icons/visa-card.svg',
                          )),
                        ),
                        Container(
                          height: 5.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            // color: AppColors.cardLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/icons/mastercard.svg',
                            fit: BoxFit.cover,
                          )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  MainButtom(
                      title: tr('Donation Now'),
                      onPressed: () async {
                        checkInternet();
                        List<DonationCa>? donationCampaigns =
                            await Donation_Ca_service.donationUser();
                        var campigainID = donationCampaigns!.first.campiganID;

                        //! Sort id Campigians

                        if (donationCampaigns != null) {
                          donationCampaigns.sort((a, b) =>
                              a.remaining_amount.compareTo(b.remaining_amount));
                          print('list of sorted donation campaigns () ' +
                              donationCampaigns.toString());

                          if (formKey.currentState!.validate()) {
                            //! Send a request to the server to create a new donation operation
                            try {
                              await makePayment(
                                value: controllerAmountDonation.text.trim(),
                                currency: 'USD',
                                onSuccess: () async {
                                  onPayPressed(controllerAmountDonation.text);
                                  onPayPressed1(campigainID.toString());
                                  onPayPressed2(controllerNameDonation.text);

                                  print(
                                      'payment is correct and done cccccccccccccccccccccccccccccccccccccccccccc' +
                                          paymentIntentData!['amount']
                                              .toString());

                                  //! Show a success dialog

                                  var succeed = await Donation_Ca_service
                                      .speedDonationServices(
                                    SpeedDonation(
                                      donor_name: controllerNameDonation.text,
                                      donation_campaign_id: campigainID!,
                                      payment_method_id: 2,
                                      amount_paid: double.parse(
                                          controllerAmountDonation.text),
                                    ),
                                  );

                                  if (kDebugMode) {
                                    print('succeed: ');
                                  }

                                  if (succeed!) {
                                    ShowDialogeDone(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Center(
                                            child: Text('Error Occurred')),
                                      ),
                                    );
                                  }
                                },
                              );
                            } catch (e) {
                              ToastContext().init(context);
                              Toast.show(
                                tr('dasadsadsadsasdad'),
                                duration: Toast.lengthLong,
                                gravity: Toast.bottom,
                              );
                            }
                          }
                        }
                      })
                ]),
              )),
        );
      });
}

class TextFormDonation extends StatelessWidget {
  const TextFormDonation({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.inputType,
    required this.controller,
    required this.formKey,
  }) : super(key: key);

  final String hintText;
  final FieldValidator validator;
  final TextInputType inputType;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
        ),
        child: Center(
          child: TextFormField(
            // maxLength: 10,
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return tr('The field is required');
              }
              return null;
            },
            keyboardType: inputType,
            autofillHints: const [AutofillHints.email],
            decoration: InputDecoration(
              // filled: true,
              //  fillColor: AppColors.scaffoldColor,
              hintText: hintText,
              hintStyle: TextStyle(
                //   color: Colors.grey, // <-- Change this
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                // fontStyle: FontStyle.normal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //  borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary1,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormSpeedDonation extends StatelessWidget {
  const TextFormSpeedDonation({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.inputType,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
        ),
        child: Center(
          child: TextFormField(
            // maxLength: 10,
            controller: controller,
            validator: validator,
            keyboardType: inputType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //  borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary1,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormNormail extends StatelessWidget {
  const TextFormNormail({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.controller,
  }) : super(key: key);

  final String hintText;

  final TextInputType inputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 2,
      ),
      child: Center(
        child: TextFormField(
          // maxLength: 10,
          controller: controller,

          keyboardType: inputType,
          //    autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(
            // filled: true,
            //  fillColor: AppColors.scaffoldColor,
            hintText: hintText,
            hintStyle: TextStyle(
              //   color: Colors.grey, // <-- Change this
              fontSize: 8.sp,
              fontWeight: FontWeight.w400,
              // fontStyle: FontStyle.normal,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              //  borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary1,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showCheckNetDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      elevation: 24,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'إغلاق',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
          ),
        ),
      ],
      title: Text(
        'تحذير',
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w700),
      ),
      content: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ),
  );
}
