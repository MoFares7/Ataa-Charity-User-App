// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/view/controllers/payment_controllers.dart';
import 'package:charity_management_system/view/screens/payment_donation_screen/speed_donation.dart';
import 'package:charity_management_system/view/widgets/main_buttom.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../configs/size.dart';
import '../../../logic/bloc/auth/auth_bloc_bloc.dart';

final paymentController = Get.put(PaymentController());

Future<dynamic> GiftPaymentOperation({
  required BuildContext context,
  required Function(String) onPayPressed,
}) async {
  
  checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showCheckDialog(context, tr('message'));
    }
  }

  Map<String, dynamic>? paymentIntentData;

  final _formKey = GlobalKey<FormState>();

  //  Future<Map<String, dynamic>>
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  tr('cash gift'),
                  style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: defaultPadding / 2,
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                TextFormDonation(
                    formKey: _formKey,
                    hintText: tr('Enter the gifted amount'),
                    controller: controllerGift,
                    validator: MultiValidator([
                      RequiredValidator(errorText: tr('The field is required')),
                      MaxLengthValidator(6,
                          errorText: tr('Cannot enter more than 6 numbers')),
                      EmailValidator(errorText: '  ادخل المبلغ الصحيح')
                    ]),
                    inputType: TextInputType.number),
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  tr('Make sure that your donation will go to the desired state'),
                  style: TextStyle(
                    fontSize: 8.sp,
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                TextFormNormail(
                    //formKey: _formKey,
                    hintText: tr('Enter a description for the gift') +
                        ' ' +
                        '(' +
                        tr('Optional') +
                        ')',
                    controller: controllerDescription,
                    inputType: TextInputType.emailAddress),
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
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return MainButtom(
                        title: tr('Gift receipt now'),
                        onPressed: () async {
                          checkInternet();
                          if (state is AuthAuthenticated) {
                            if (_formKey.currentState!.validate()) {
                              await makePayment(
                                value: controllerGift.text.trim(),
                                currency: 'USD',
                                onSuccess: () {
                                  //? Send a request to the server to create a new Gift operation
                                  onPayPressed(controllerGift.text);
                                },
                              );
                            }
                          } else {
                            showNotLoggedInDialog(context);
                          }
                        });
                  },
                )
              ])),
        );
      });
}
