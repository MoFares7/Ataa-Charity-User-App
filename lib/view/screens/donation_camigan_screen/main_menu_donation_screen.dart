import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:charity_management_system/view/screens/donation_camigan_screen/donation_campigan_screen.dart';
import 'package:charity_management_system/view/screens/donation_camigan_screen/my_donations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../configs/size.dart';
import '../profile_screen/profile/profile_screen.dart';

class MainMenuDonationScreen extends StatelessWidget {
  const MainMenuDonationScreen({Key? key}) : super(key: key);

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
          tr('Donation'),
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: Column(
        children: [
          ProfileCard(
            icon: Icons.spa_outlined,
            title: tr('Start donating'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DonationCampiganScreen()),
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
                  icon: Icons.tips_and_updates,
                  title: tr('My Donation'),
                  onTap: () async {
                    final userID = await loadUserID();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyDonationsScreen(
                          userID: userID,
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
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
