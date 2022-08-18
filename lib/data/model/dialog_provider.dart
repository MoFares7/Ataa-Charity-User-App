import 'package:charity_management_system/configs/size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

mixin DialogProvider {
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tr('login'),
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 9.sp,
                      ),
                    ),
                    const SizedBox(width: defaultPadding),
                    Icon(
                      Icons.login,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
