import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../configs/size.dart';

class MainButtom extends StatelessWidget {
  final String title;
  final Function onPressed;
  const MainButtom({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 5),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).iconTheme.color,
            border: Border.all()),
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          height: 20,
          minWidth: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 1.5),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 9.sp, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
