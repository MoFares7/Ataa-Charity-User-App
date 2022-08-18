// ignore_for_file: unused_field, non_constant_identifier_names, avoid_print, constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:developer';
import 'package:charity_management_system/data/model/add_donation_oper.dart';
import 'package:charity_management_system/data/model/donation_ca.dart';
import 'package:charity_management_system/data/model/speed_donation_model.dart';
import 'package:http/http.dart' as http;

import '../../configs/helpers.dart';

// ignore: camel_case_types
class Donation_Ca_service {
  //static const mainUrl = 'http://192.168.1.5:8000/api';
  static const donationUrl = '/donation-campaign/';
  static const addDonationUrl = '/donation-operation/';

  // Accept header value
  static const _acceptValue = 'application/json';
  static const _acceptKey = 'Accept';
  static const _authorizationKey = 'Authorization';

// Name Static to connect with model
  static const _userId = 'user_id';
  static const _donationCampignId = 'donation_campaign_id';
  static const _paymentMethodId = 'payment_method_id';
  static const _amountPaid = 'amount_paid';

  late Map jsondata;

  static Future<List<DonationCa>?> donationUser() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(mainUrl + donationUrl),
        headers: {
          _acceptKey: _acceptValue,
        },
      );

      if (response.statusCode == 200) {
        print(
            'The statusCode to get Campigin Donations  ===> ${response.statusCode.toString()}');

        try {
          final parsed = json
              .decode(response.body)['Donation Campaigns']
              .cast<Map<String, dynamic>>();
          return parsed
              .map<DonationCa>((json) => DonationCa.fromJson(json))
              .toList();
        } catch (e) {
          //print('result' + e.toString());
        }
      } else if (response.statusCode == 400) {
        return null;
      }

      log('The Response status Code to campigains After Decode ===> ${response.body.toString()}');
    } catch (ex) {
      return null;
    }
    return null;
  }

  // STORE DONATION OPERATION
  static Future<bool?> addDonationOperation(
    AddDonationOperation addDonationOperation,
  ) async {
    var response;

    print('Donation Services()=> ${addDonationOperation.toJson()}');
    try {
      response = await http.post(
        Uri.parse(mainUrl + addDonationUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(addDonationOperation.toJson()),
      );
      // .timeout(const Duration(seconds: 3));
      print('ffffffffffffffffffffffffff ===> ${response.body.toString()}');
      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 201) {
        return true;
      }
      print('rrrrrrrrrrrrrrrrrrrr ===> ${response.statusCode.toString()}');
    } catch (e) {
      return false;
    }
    return false;
  }

  static Future<List<AddDonationOperation>?>
      getMyPreviousDonationOperations() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(mainUrl + addDonationUrl),
        headers: {
          _acceptKey: _acceptValue,
        },
      );
      if (response.statusCode == 200) {
        try {
          final parsed = json
              .decode(response.body)['ALL Donation Operation']
              .cast<Map<String, dynamic>>();
          return parsed
              .map<AddDonationOperation>(
                  (json) => AddDonationOperation.fromJson(json))
              .toList();
        } catch (e) {
          print('result of donation operations: ' + e.toString());
        }
      } else if (response.statusCode == 400) {
        return null;
      }
    } catch (ex) {
      return null;
    }
    return null;
  }

  static Future<bool?> speedDonationServices(
    SpeedDonation speedDonation,
  ) async {
    var response;

    print('Donation Services()=> ${speedDonation.toJson()}');
    try {
      response = await http.post(
        Uri.parse(mainUrl + addDonationUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(speedDonation.toJson()),
      );
      // .timeout(const Duration(seconds: 3));
      print(
          'the speed donation response body ===> ${response.body.toString()}');
      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      print(
          'the speed Donation status code  ===> ${response.statusCode.toString()}');
    } catch (e) {
      print('the error in speed donation ===> ${e.toString()}');
    }
    return false;
  }
}
