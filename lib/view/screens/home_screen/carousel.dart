import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreateCarousel extends StatelessWidget {
  const CreateCarousel({
    Key? key,
    required this.imageUrl2,
    required this.index,
    required this.title,
    required this.subTitle,
    required this.onTap,
  }) : super(key: key);

  final String imageUrl2;
  final int index;
  final String title;
  final String subTitle;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: size.width / 1.3,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        subTitle,
                        style: TextStyle(fontSize: 8.sp),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    MaterialButton(
                        onPressed: () {
                          onTap();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.cardLight),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding / 2,
                                  horizontal: defaultPadding * 2),
                              child: Text(
                                tr('Start Now'),
                                style: const TextStyle(
                                    color: AppColors.textDark, fontSize: 10),
                              )),
                        )),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // height: 40.h,
                width: size.width / 5,
                //   margin: const EdgeInsets.symmetric(horizontal: defultPadding),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/green-card.png'),
                        fit: BoxFit.cover),
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
