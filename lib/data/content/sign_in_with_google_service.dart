// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/helpers.dart';

class Sign_In_Google_Services {
  static const googleUrl = '';


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
        Uri.parse(mainUrl + googleUrl),
        body: {
        //'token' : token;
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = jsonDecode(response.body)['user'];
        print(user);
        if (user != null) {
          // Store usr id to shared preferenecs
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', int.parse(user['id'].toString()));
        }
        return jsonDecode(response.body)['access_token'];
      } else {
        return print("Some fields are required or incorrect");
      }
    } catch (ex) {
      return null;
    }
  }

}
