import 'package:charity_management_system/configs/size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class UnExpectedErrorWidget extends StatelessWidget {
  const UnExpectedErrorWidget({
    Key? key,
    this.onRetry,
  }) : super(key: key);
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svg/error_widget.svg',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Text(
            tr('un_expected_error_occurred'),
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
                    fontSize: 7.sp, color: Theme.of(context).dividerColor),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding * 0.5,
                  horizontal: defaultPadding * 3,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
