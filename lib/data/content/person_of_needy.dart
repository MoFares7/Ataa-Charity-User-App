// ignore_for_file: unused_field, non_constant_identifier_names, avoid_print, constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:charity_management_system/data/model/person.dart';
import 'package:http/http.dart' as http;

import '../../configs/helpers.dart';

// ignore: camel_case_types
class PersonServices {
  //static const mainUrl = 'http://192.168.1.5:8000/api';
  static const getPerson = '/person/';

  // Accept header value
  static const _acceptValue = 'application/json';
  static const _acceptKey = 'Accept';
  static const _authorizationKey = 'Authorization';

  static Future<List<Person>?> getPersonService() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(mainUrl + getPerson),
        headers: {
          _acceptKey: _acceptValue,
        },
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Person>((json) => Person.fromJson(json)).toList();
      } else if (response.statusCode == 400) {
        return null;
      }
    } catch (ex) {
      return null;
    }
    return null;
  }
}
