import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../configs/size.dart';

class DonationButton extends StatelessWidget {
  const DonationButton({
    Key? key,
    required this.textcolor,
    required this.onPressed,
  }) : super(key: key);

  final Color textcolor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).iconTheme.color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultPadding / 2, horizontal: defaultPadding * 2),
          child: Text(
            LocaleKeys.donation.tr(),
            style: TextStyle(color: textcolor, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
