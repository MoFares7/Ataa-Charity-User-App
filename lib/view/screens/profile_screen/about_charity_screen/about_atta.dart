import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class AboutAtta extends StatelessWidget {
  const AboutAtta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            splashRadius: 20,
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Theme.of(context).dividerColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            LocaleKeys.about_ataa_profile.tr(),
            style: TextStyle(
                color: Theme.of(context).dividerColor, fontSize: 12.sp),
          ),
        ),
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('who are we'),
                        style: TextStyle(
                            fontSize: 12.sp,
                            // color: AppColors.primary1,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      Text(
                        tr('descrip1'),
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      Text(
                        tr('foundation'),
                        style: TextStyle(
                            fontSize: 12.sp,
                            // color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      Text(
                        tr('des2crip2'),
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          tr('vision ataa'),
                          style: TextStyle(
                              fontSize: 12.sp,
                              // color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              height: 35.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                color: AppColors.cardLight,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding,
                                    horizontal: defaultPadding),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/see.svg',
                                      height: 5.h,
                                      width: 50,
                                    ),
                                    const SizedBox(
                                      height: defaultPadding,
                                    ),
                                    Text(
                                      tr('Vision'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 10.sp),
                                    ),
                                    const SizedBox(
                                      height: defaultPadding,
                                    ),
                                    Center(
                                      child: Text(
                                        tr('sub_vision'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8.sp),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                            child: Container(
                              height: 35.h,
                              width: 45.w,
                              decoration: BoxDecoration(
                                color: AppColors.cardLight,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding,
                                    horizontal: defaultPadding),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/goal.svg',
                                      height: 5.h,
                                      width: 50,
                                    ),
                                    const SizedBox(
                                      height: defaultPadding,
                                    ),
                                    Text(
                                      tr('Gool'),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: defaultPadding / 2,
                                    ),
                                    Text(
                                      tr('sub_gool'),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 8.sp),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          tr('ataa_gool'),
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.cardLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  // height: 170,
                                  // width: 200.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardLight,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding,
                                        horizontal: defaultPadding),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/signal.svg',
                                          height: 40,
                                          width: 40,
                                          color: AppColors.primary1,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        Text(
                                          tr('gool_1'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  // height: 170,
                                  //  width: 200.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardLight,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding,
                                        horizontal: defaultPadding),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/star.svg',
                                          height: 40,
                                          width: 40,
                                          color: AppColors.primary1,
                                        ),
                                        const SizedBox(height: defaultPadding),
                                        Text(
                                          tr('gool_2'),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  //   height: 170,
                                  //  width: 200.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardLight,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding,
                                        horizontal: defaultPadding),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/write.svg',
                                          height: 40,
                                          width: 40,
                                          color: AppColors.primary1,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        Text(
                                          tr('gool_3'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  //  height: 170,
                                  //  width: 200.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardLight,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding,
                                        horizontal: defaultPadding),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/loves.svg',
                                          height: 40,
                                          width: 40,
                                          color: AppColors.primary1,
                                        ),
                                        const SizedBox(
                                          height: defaultPadding,
                                        ),
                                        Text(
                                          tr('gool_4'),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 8.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                      )
                    ]),
              );
            }));
  }
}
