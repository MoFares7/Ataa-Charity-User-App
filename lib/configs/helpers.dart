// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

abstract class Helpers {
  static final random = Random();

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/300/300?random=$randomInt';
  }

  static DateTime randomDate() {
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }

  static _getMoneyLevel(double amount) {
    if (amount > 1000000000) {
      return MoneyLevel.billion;
    } else if (amount > 1000000) {
      return MoneyLevel.million;
    } else if (amount > 1000) {
      return MoneyLevel.thousand;
    }
    return MoneyLevel.pound;
  }

  static String getMoneyAmount(double amount) {
    switch (_getMoneyLevel(amount)) {
      case MoneyLevel.billion:
        return plural('billion', (amount / 1000000000));
      case MoneyLevel.million:
        return plural('million', (amount / 1000000));
      case MoneyLevel.thousand:
        return plural('thousand', (amount / 1000));
      case MoneyLevel.pound:
        return plural('pound', amount);
      default:
        return plural('pound', amount);
    }
  }

  // STRIPE PUBLISHABLE
  static const stripePublishableKey =
      'pk_test_51HMhFAA3qSFwIzsUQkXyDORaPTWPIEvBbdKl60ETcv3MDCIT4YS00S2Yw6iHRx35Tv1eeAc9471mjtznwUBP7UeY006JbUappF';

  static const oneSignalAppId = '78c6530d-8bb1-4559-9713-08c875e25b3e';
}

TextEditingController controllerDonation = TextEditingController();
TextEditingController controllerGift = TextEditingController();
TextEditingController controllerDescription = TextEditingController();
final TextEditingController senderGift = TextEditingController();
final TextEditingController reciverGift = TextEditingController();
final TextEditingController phoneNumberSender = TextEditingController();

Future<int> loadUserID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int? intValue = prefs.getInt('user_id');
  return intValue ?? -1;
}

// Constants for assets' paths
const String errorWidgetSvgAsset = 'assets/svg/error_widget.svg';
const String noDataWidgetSvgAsset = 'assets/svg/no_data_widget.svg';

var userId = loadUserID();
const paymentMethodID = 2;

final paidAmount = controllerDonation.text.trim();
final giftPaidAmount = controllerGift.text.trim();
final senderGifts = senderGift.text.trim();
final reciverGifts = reciverGift.text.trim();
final phoneSenderGift = phoneNumberSender.text.trim();
//! MainUrl to connect with server
const baseUrl = 'http://ataacharitysystem.000webhostapp.com';
const mainUrl = '$baseUrl/api';

enum MoneyLevel {
  pound,
  thousand,
  million,
  billion,
}

//! to check if can Login or not
Future<bool?> showNotLoggedInDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Text(
            tr('you_are_not_logged_in'),
            style: TextStyle(fontSize: 10.sp),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ADD IMAGE TO INICATE THAT USER IS NOT LOGGED IN
            SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2,
                child: Lottie.asset('assets/login.json')),
            const SizedBox(height: defaultPadding * 0.5),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Row(
                children: [
                  Text(
                    tr('login'),
                    style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 9.sp),
                  ),
                  const SizedBox(width: defaultPadding * 0.5),
                  Icon(Icons.login, color: Theme.of(context).iconTheme.color),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

void showCheckDialog(BuildContext context, String text) {
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
            tr('Closed'),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
          ),
        ),
      ],
      title: Text(
        tr('Warning'),
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

void check(
  BuildContext context,
) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Center(
                  child: Text(
                tr('Warrning'),
                style: TextStyle(fontSize: 10.sp),
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Lottie.asset('assets/no net.json')),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Center(
                      child: Text(
                    tr('no internet'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 9.sp),
                  )),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              tr('Closed'),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
            ),
          ),
        );
      });
}

Future<dynamic> ShowDialogeDone(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 2,
            child: Lottie.asset(
              'assets/done.json',
            )),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(tr('Done')),
        ),
      ],
    )),
  );
}
