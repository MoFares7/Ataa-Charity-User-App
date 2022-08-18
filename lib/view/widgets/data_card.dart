import 'package:charity_management_system/configs/size.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    this.onPressed,
    this.child,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  final Widget? child;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding * 0.5,
          horizontal: defaultPadding,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          border: border,
        ),
        child: child,
      ),
    );
  }
}
