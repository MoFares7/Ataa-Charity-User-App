import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:charity_management_system/view/screens/donation_camigan_screen/main_menu_donation_screen.dart';
import 'package:charity_management_system/view/screens/gift_screen/gift_main_screen.dart';
import 'package:charity_management_system/view/screens/profile_screen/profile/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../volunter_campign_screen/main_mune_volunteer_screen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

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
          LocaleKeys.activity.tr(),
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: Column(
        children: [
          ProfileCard(
            icon: Icons.domain_rounded,
            title: tr('Donation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainMenuDonationScreen()),
              );
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          ProfileCard(
            icon: Icons.volunteer_activism_outlined,
            title: tr('volunteer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainMuneVolunteerScreen()),
              );
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          ProfileCard(
              icon: Icons.tips_and_updates,
              title: LocaleKeys.gift.tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainMenuGift()),
                );
              }),
          const SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }
}
