import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/configs/size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.title,
    this.onRetry,
  }) : super(key: key);

  final VoidCallback? onRetry;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            noDataWidgetSvgAsset,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.sp,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(height: defaultPadding * 0.5),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: onRetry,
              child: Text(
                tr('try_again'),
                style: TextStyle(
                    fontSize: 8.sp, color: Theme.of(context).dividerColor),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding * 0.5,
                  horizontal: defaultPadding * 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
