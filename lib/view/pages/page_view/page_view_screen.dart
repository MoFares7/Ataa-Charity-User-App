import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/model/page_banner.dart';
import 'package:charity_management_system/view/pages/page_view/indictor.dart';
import 'package:charity_management_system/view/screens/login_screen/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pageitem.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child:  Text(
                      tr('skip'),
                      style: const TextStyle(color: AppColors.textDark),
                    )),
                SvgPicture.asset(
                  "assets/icons/appbar_logo.svg",
                  height: 70,
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Expanded(
              child: Container(
                  height: 160,
                  decoration: const BoxDecoration(
                      //  color: Colors.blue,
                      ),
                  child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      controller: PageController(viewportFraction: 1),
                      itemCount: pageBannerList.length,
                      itemBuilder: (context, index) {
                        var _scale = _selectedIndex == index ? 1.0 : 0.8;
                        //var banner = pageBannerList[index];

                        return TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 300),
                          tween: Tween(begin: _scale, end: _scale),
                          //   curve: Curve.ease,
                          builder: (BuildContext context, double value,
                              Widget? child) {
                            return Transform.scale(
                              scale: value,
                              child: child,
                            );
                          },
                          child: PageItem(
                            pageBanner: pageBannerList[index],
                          ),
                        );
                      })),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  pageBannerList.length,
                  (index) => Indicator(
                      isActive: _selectedIndex == index ? true : false),
                )
              ],
            ),
            // Image.asset("assets/images/donation_card.png"),
            const SizedBox(
              height: defaultPadding * 2,
            ),

            const SizedBox(
              height: defaultPadding * 2,
            ),
          ],
        ),
      ),
    );
  }
}
