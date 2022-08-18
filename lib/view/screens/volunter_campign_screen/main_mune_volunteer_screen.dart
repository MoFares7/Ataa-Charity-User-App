import 'package:charity_management_system/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/my_activities.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/volunter_campign_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../configs/size.dart';
import '../profile_screen/profile/profile_screen.dart';

class MainMuneVolunteerScreen extends StatelessWidget {
  const MainMuneVolunteerScreen({Key? key}) : super(key: key);

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
          tr('volunteer'),
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: Column(
        children: [
          ProfileCard(
            icon: Icons.spa_outlined,
            title: tr('Start volunteering'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VolunterCampignScreen()),
              );
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is! AuthAuthenticated) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileCard(
                    icon: Icons.tips_and_updates,
                    title: tr('My Volunteer Campaigns'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyActivitiesScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: defaultPadding)
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
