// ignore_for_file: avoid_print, non_constant_identifier_names
import 'dart:convert';

import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/view/widgets/main_buttom.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/size.dart';
import '../../../data/content/donation_service.dart';
import '../../../data/model/add_donation_oper.dart';
import '../../../logic/bloc/auth/auth_bloc_bloc.dart';
import '../login_screen/login_screen.dart';
import 'speed_donation.dart';

Future<dynamic> NormalDonationScreen({
  required BuildContext context,
  required Function(String) onPayPressed,
  required int campaignID,
}) async {
  checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      check(context);
    }
  }

  Map<String, dynamic>? paymentIntentData;
  final _formKey = GlobalKey<FormState>();
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
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: false,
              style: ThemeMode.light,
              merchantCountryCode: 'US',
              merchantDisplayName: 'ANNIE'));

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
              const SnackBar(content: Text("paid successfully")),
            );

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
            ),
          );
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('Donate to campaign'),
                style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
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
              Text(
                tr('Make sure that your donation will go to the selected case'),
                style: TextStyle(
                  fontSize: 8.sp,
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              TextFormDonation(
                  formKey: _formKey,
                  hintText: tr('Enter the donation amount'),
                  controller: controllerDonation,
                  validator: MultiValidator([
                    RequiredValidator(errorText: tr('The field is required')),
                    MaxLengthValidator(8,
                        errorText: 'لا يمكن إدخال أكثر من 8 حرف'),
                    EmailValidator(errorText: '  ادخل المبلغ الصحيح')
                  ]),
                  inputType: TextInputType.number),
              const SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                return MainButtom(
                    //  textcolor: AppColors.textLigth,
                    title: tr('Donation Now'),
                    onPressed: () async {
                      checkInternet();
                      if (_formKey.currentState!.validate()) {
                        if (state is AuthAuthenticated) {
                          await makePayment(
                              value: controllerDonation.text.trim(),
                              currency: 'USD',
                              onSuccess: () async {
                                //? Send a request to the server to create a new donation operation
                                onPayPressed(paidAmount);
                                print(
                                    'payment cccccccccccccccccccccccccccccccccccccccccccc' +
                                        paymentIntentData!['amount']
                                            .toString());
                                //? Show a success dialog

                                // Get user id from shared preferences
                                final prefs =
                                    await SharedPreferences.getInstance();

                                final userID = prefs.getInt('user_id');
                                const paymentMethodID = '2';

                                var succeed = await Donation_Ca_service
                                    .addDonationOperation(
                                  AddDonationOperation(
                                    user_id: userID,
                                    donation_campaign_id: campaignID,
                                    payment_method_id: paymentMethodID,
                                    amount_paid: paidAmount,
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
                                      content: Text('Error Occurred'),
                                    ),
                                  );
                                }
                              });
                        } else {
                          final bool? goToLoginScreen =
                              await showNotLoggedInDialog(context);

                          if (goToLoginScreen != null && goToLoginScreen) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          }
                        }
                      }
                    });
              })
            ],
          ),
        ),
      );
    },
  );
}
