import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:charity_management_system/view/screens/profile_screen/about_charity_screen/about_atta.dart';
import 'package:charity_management_system/view/screens/profile_screen/about_charity_screen/conect_us.dart';
import 'package:charity_management_system/view/screens/profile_screen/profile/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../configs/size.dart';

class MainAboutScreen extends StatelessWidget {
  const MainAboutScreen({Key? key}) : super(key: key);

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
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: defaultPadding / 3,
          ),
          ProfileCard(
            icon: Icons.privacy_tip_outlined,
            title: LocaleKeys.about_ataa_profile.tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAtta()),
              );
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          ProfileCard(
            icon: Icons.phone,
            title: LocaleKeys.center_contact.tr(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConnectUs()),
              );
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }
}
