// ignore_for_file: avoid_print, non_constant_identifier_names, unused_element

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<dynamic> StripePayments(BuildContext context) async {
  Map<String, dynamic>? paymentIntentData;

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
}
