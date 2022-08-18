import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'constants/nav_items.dart';

part 'navigation_state.dart';

class NavigationBloc extends Cubit<NavigationState> {
  NavigationBloc() : super(const NavigationState(NavbarItem.home, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(const NavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.donation_cam:
        emit(const NavigationState(NavbarItem.donation_cam, 1));
        break;
      case NavbarItem.speed_donation:
        emit(const NavigationState(NavbarItem.speed_donation, 2));
        break;
      case NavbarItem.volunteer:
        emit(const NavigationState(NavbarItem.volunteer, 3));
        break;
      case NavbarItem.profile:
        emit(const NavigationState(NavbarItem.profile, 4));
        break;
    }
  }
}
