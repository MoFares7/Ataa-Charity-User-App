// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable, avoid_types_as_parameter_names
import 'dart:async';

import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/logic/navigation/constants/nav_items.dart';
import 'package:charity_management_system/logic/navigation/navigation_bloc.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:charity_management_system/view/screens/donation_camigan_screen/donation_campigan_screen.dart';
import 'package:charity_management_system/view/screens/payment_donation_screen/speed_donation.dart';
import 'package:charity_management_system/view/screens/profile_screen/profile/profile_screen.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/volunter_campign_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import 'home_screen.dart';

class RootScreenState extends StatefulWidget {
  const RootScreenState({Key? key}) : super(key: key);

  @override
  State<RootScreenState> createState() => _RootScreenStateState();
}

///  this class to Root Navigation bar
class _RootScreenStateState extends State<RootScreenState> {
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_UpdateConnectionState);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<bool?> showOutDialog() => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              tr(
                'Do you want to exit the application?',
              ),
              style: TextStyle(fontSize: 10.sp),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(tr('yes'),
                      style: TextStyle(
                          fontSize: 9.sp,
                          color: Theme.of(context).iconTheme.color))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(tr('no'),
                      style: TextStyle(
                          fontSize: 9.sp,
                          color: Theme.of(context).iconTheme.color)))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showOutDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Material(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: BottomNavigationBar(
                    elevation: 0,
                    // backgroundColor: Colors.transparent,
                    currentIndex: state.index,
                    selectedItemColor: Theme.of(context).iconTheme.color,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: false,
                    showSelectedLabels: true,
                    selectedFontSize: 10,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.home,
                              size: 25,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ],
                        ),
                        label: LocaleKeys.main.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/charity.svg",
                              height: 25,
                              width: 25,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ],
                        ),
                        label: LocaleKeys.donation_cam.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                SpeedDonationScreen(
                                  context: context,
                                  onPayPressed: (paidAmount) async {},
                                  onPayPressed1: (String) {},
                                  onPayPressed2: (String) {},
                                );
                              },
                              child: Container(
                                height: 53,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: AppColors.textLigth,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/branch.svg",
                                    height: 25,
                                    width: 25,
                                    color: Theme.of(context).hoverColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        label: LocaleKeys.donation.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/volunteer.svg",
                              height: 25,
                              width: 25,
                              color: Theme.of(context).iconTheme.color,
                            )
                          ],
                        ),
                        label: LocaleKeys.volunteer_cam.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 25,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ],
                        ),
                        label: LocaleKeys.profile.tr(),
                      ),
                    ],
                    onTap: (index) {
                      if (index == 0) {
                        BlocProvider.of<NavigationBloc>(context)
                            .getNavBarItem(NavbarItem.home);
                      } else if (index == 1) {
                        BlocProvider.of<NavigationBloc>(context)
                            .getNavBarItem(NavbarItem.donation_cam);
                      } else if (index == 2) {
                        BlocProvider.of<NavigationBloc>(context)
                            .getNavBarItem(NavbarItem.speed_donation);
                      } else if (index == 3) {
                        BlocProvider.of<NavigationBloc>(context)
                            .getNavBarItem(NavbarItem.volunteer);
                      } else if (index == 4) {
                        BlocProvider.of<NavigationBloc>(context)
                            .getNavBarItem(NavbarItem.profile);
                      }
                    },
                  ),
                ));
          },
        ),
        body: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
          if (state.navbarItem == NavbarItem.home) {
            return const HomeScreen();
          } else if (state.navbarItem == NavbarItem.donation_cam) {
            return const DonationCampiganScreen();
          } else if (state.navbarItem == NavbarItem.volunteer) {
            return const VolunterCampignScreen();
          } else if (state.navbarItem == NavbarItem.profile) {
            return const ProfileScreen();
          }
          return Container();
        }),
      ),
    );
  }

  ///  This Future to check if can mobile is coonected with internet
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(result, true);
    } else {
      showStatus(result, false);
    }
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content: Text(status
            ? tr('The Mobile is Connected with interntet')
            : tr('The Mobile is not Connected with interntet')),
        backgroundColor: status ? AppColors.primary1 : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
