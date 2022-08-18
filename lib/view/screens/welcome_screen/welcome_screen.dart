import 'dart:async';

import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/view/pages/page_view/page_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PageViewScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppColors.primary1,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.primary1,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/splash_bg.png")),
                ),
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/light_logo.svg',
                    color: Colors.white70,
                  ),
                  const SizedBox(height: defaultPadding),
                  const Text(
                    "وما تنفقوا من خير يوفّ إليكم وأنتم لا تظلمون ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
