import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:charity_management_system/view/screens/home_screen/home_screen.dart';
import 'package:charity_management_system/view/screens/profile_screen/profile/profile_screen.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/volunter_campign_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/size.dart';
import '../donation_camigan_screen/donation_campigan_screen.dart';

class BottomsNavigationBar extends StatelessWidget {
  const BottomsNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 12, horizontal: defaultPadding / 2),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.home,
                    size: 30,
                    color: AppColors.primary1,
                  ),
                  Text(
                    LocaleKeys.main.tr(),
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DonationCampiganScreen()),
                );
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/icons/charity.svg",
                    color: AppColors.primary1,
                  ),
                  const Text(
                    LocaleKeys.donation_cam,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: GestureDetector(
              onTap: () {
                //   SpeedDonationScreen(context);
              },
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.textLigth,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/branch.svg",
                        color: AppColors.primary1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VolunterCampignScreen()),
                );
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/icons/volunteer.svg",
                    color: AppColors.primary1,
                  ),
                  const Text(
                    LocaleKeys.volunteer_cam,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 7, horizontal: defaultPadding / 2),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              child: Column(
                children: const [
                  Icon(
                    Icons.person,
                    size: 25,
                    color: AppColors.primary1,
                  ),
                  Text(
                    LocaleKeys.profile,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
