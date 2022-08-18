// ignore_for_file: unused_field, non_constant_identifier_names, avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/helpers.dart';

class AuthService {
  //static String mainUrl = 'http://192.168.1.5:8000/api';
  static String registerUrl = '/register';
  static String loginUrl = '/login';
  static String loginWithGoogleUrl = '/social/in';
  static String logoutUrl = '/logout';

  static const _firstNameKey = 'first_name';
  static const _lastNameKey = 'last_name';
  static const _emailKey = 'email';
  static const _passwordKey = 'password';
  static const _authorizationKey = 'Authorization';

  // Accept header value
  static const _acceptValue = 'application/json';

  // Bearer word for authorization header
  static const _bearer = 'Bearer ';

  Future<dynamic> registerUser(
    String first_name,
    String last_name,
    String email,
    String password,
  ) async {
    if (first_name.isEmpty ||
        last_name.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      return null;
    }

    http.Response response;
    try {
      response = await http.post(
        Uri.parse(mainUrl + registerUrl),
        body: {
          _firstNameKey: first_name,
          _lastNameKey: last_name,
          _emailKey: email,
          _passwordKey: password,
        },
      );
      print('the status code in register' + response.statusCode.toString());
      print('the status code in register' + response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = jsonDecode(response.body)['user'];
        print(user);
        if (user != null) {
          // Store usr id to shared preferenecs
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', int.parse(user['id'].toString()));
        }
        return jsonDecode(response.body)['access_token'];
      }
      if (response.statusCode == 423) {
        print(' sorry email dublicated');
      } else {
        return print("Some fields are required or incorrect");
      }
    } catch (ex) {
      return null;
    }
  }

  Future<dynamic> loginUser(String email, String password) async {
    // validate email & password
    if (email.isEmpty || password.isEmpty) {
      return null;
    }

    http.Response response;
    try {
      // pass data in request body of post request method
      response = await http.post(
        Uri.parse(mainUrl + loginUrl),
        headers: {
          //   _headerKey: ,
          'Accpet': _acceptValue,
        },
        body: {
          _emailKey: email,
          _passwordKey: password,
        },
      );
      print('the status code in login' + response.statusCode.toString());
      print('the status code in login' + response.body.toString());
      if (response.statusCode == 200) {
        final user = jsonDecode(response.body)['user'];
        if (user != null) {
          // Store usr id to shared preferenecs
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', user['id']);
          await prefs.setString('email', user['email']);
          await OneSignal.shared.setEmail(email: user['email']);
        }
        return jsonDecode(response.body)['access_token'];
      }
    } catch (ex) {
      return null;
    }
    return null;
  }

  Future logoutUser(String token) async {
    if (token.isEmpty) {
      return null;
    }

    http.Response response;
    try {
      response = await http.post(
        Uri.parse(mainUrl + logoutUrl),
        headers: {
          _authorizationKey: _bearer + token,
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      }
    } catch (ex) {
      return null;
    }
    return null;
  }

  Future loginWithGoogle(String googleToken) async {
    if (googleToken.isEmpty) {
      return null;
    }
    http.Response response;
    try {
      response = await http.post(
        Uri.parse(mainUrl + loginWithGoogleUrl + '/google'),
        body: {
          'provider_name': 'google',
          'access_token': googleToken,
        },
      );
      if (response.statusCode == 200) {
        final user = jsonDecode(response.body)['user'];
        if (user != null) {
          // Store usr id to shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', user['id']);
          await prefs.setString('email', user['email']);
          await OneSignal.shared.setEmail(email: user['email']);
        }
        return jsonDecode(response.body)['access_token'];
      }
    } catch (ex) {
      return null;
    }
    return null;
  }
}
