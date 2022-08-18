// ignore_for_file: unused_field, non_constant_identifier_names, avoid_print, constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:charity_management_system/data/model/statistics.dart';
import 'package:http/http.dart' as http;

import '../../configs/helpers.dart';

// ignore: camel_case_types
class TotalAtaaServices {
  //static const mainUrl = 'http://192.168.1.5:8000/api';
  static const getTotal = '/get-total/';

  // Accept header value
  static const _acceptValue = 'application/json';
  static const _acceptKey = 'Accept';
  static const _authorizationKey = 'Authorization';

  static Future<Statistics?> getTotalAtaaService() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(mainUrl + getTotal),
        headers: {
          _acceptKey: _acceptValue,
        },
      );

      if (response.statusCode == 200) {
        print('The response before in total ataa ' + response.body.toString());
        print(
            'The statusCode  in total ataa ' + response.statusCode.toString());
        final parsed = Map<String, dynamic>.from(json.decode(response.body));

        return Statistics.fromJson(parsed);
      } else if (response.statusCode == 400) {
        return null;
      }
      print('The response after in total ataa ' + response.body.toString());
    } catch (ex) {
      print('The error in total ataa ' + ex.toString());
    }
    return null;
  }
}
