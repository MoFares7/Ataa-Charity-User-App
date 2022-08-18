import 'package:charity_management_system/configs/theme.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 22.0 : 8.0,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
            color: isActive ? AppColors.primary1 : Colors.grey,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
