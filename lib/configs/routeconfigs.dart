import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/view/screens/home_screen/home_screen.dart';
import 'package:charity_management_system/view/screens/login_screen/login_screen.dart';

import 'package:charity_management_system/view/screens/signUp_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();

      default:
        return error();
    }
  }
}

Route error() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
          title: const Text('Error'), backgroundColor: AppColors.primary1),
    ),
  );
}
