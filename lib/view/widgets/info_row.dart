import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({
    Key? key,
    this.title,
    this.value,
    this.titleColor,
    this.valueColor,
  }) : super(key: key);

  final String? title;
  final String? value;
  final Color? titleColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
            color: titleColor ?? Theme.of(context).dividerColor,
            fontSize: 8.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value ?? '',
          style: TextStyle(
            color:
                valueColor ?? Theme.of(context).dividerColor.withOpacity(0.5),
            fontSize: 7.sp,
          ),
        ),
      ],
    );
  }
}
