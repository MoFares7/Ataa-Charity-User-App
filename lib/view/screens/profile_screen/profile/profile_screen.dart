import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:charity_management_system/logic/bloc/logout/logout_bloc_bloc.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:charity_management_system/view/screens/login_screen/login_screen.dart';
import 'package:charity_management_system/view/screens/profile_screen/about_charity_screen/main_about_screen.dart';
import 'package:charity_management_system/view/screens/profile_screen/active_screen/activity_screen.dart';
import 'package:charity_management_system/view/screens/profile_screen/setting_screen/settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.profile.tr(),
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const SizedBox();
              }
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SvgPicture.asset(
                      'assets/icons/add-user.svg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Text(
                    LocaleKeys.title_profile.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 3,
                      vertical: defaultPadding,
                    ),
                    child: Text(
                      LocaleKeys.subtitle_profile.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).iconTheme.color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 16,
                        ),
                        child: Text(
                          LocaleKeys.login.tr(),
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                ],
              );
            }),
            ProfileCard(
              icon: Icons.settings,
              title: LocaleKeys.settings.tr(),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            ProfileCard(
              icon: Icons.spa_outlined,
              title: LocaleKeys.activity.tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActivityScreen()),
                );
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            ProfileCard(
              icon: Icons.privacy_tip_outlined,
              title: LocaleKeys.about_ataa_profile.tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainAboutScreen()),
                );
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return ProfileCard(
                    icon: Icons.logout_outlined,
                    title: LocaleKeys.logout.tr(),
                    onTap: () async {
                      showLogOutDialog(context);
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      ),
//bottomNavigationBar: const BottomsNavigationBar(),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: defaultPadding * 1.5, horizontal: defaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Icon(icon),
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          //   color: Theme.of(context).textSelectionColor,
                          fontSize: 10.sp),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      elevation: 24,
      actions: [
        TextButton(
          onPressed: () {
            context.read<LogoutBloc>().add(LogoutEventPressed());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: Text(
            tr('yes'),
            style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).iconTheme.color
                //color: Colors.black
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(tr('no'),
              style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).iconTheme.color
                  //color: Colors.black
                  )),
        ),
      ],
      title: Text(
        tr('Warrning'),
        style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).iconTheme.color
            //color: Colors.black
            ),
      ),
      content: Text(
        tr('Do you want to log out?'),
        style: TextStyle(
          fontSize: 8.sp,
          fontWeight: FontWeight.w700,
          //color: Colors.black
        ),
      ),
    ),
  );
}
