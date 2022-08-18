// ignore_for_file: unused_field, non_constant_identifier_names, avoid_print, constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:developer';

import 'package:charity_management_system/data/model/get_gift.dart';
import 'package:http/http.dart' as http;

import '../../configs/helpers.dart';

// ignore: camel_case_types
class GiftServices {

  static const mainGift = '/gift';

  // Accept header value
  static const _acceptValue = 'application/json';
  static const _acceptKey = 'Accept';
  static const _authorizationKey = 'Authorization';

  Future<List<GiftModel>?> getGiftService() async {
    var response;
    try {
      response = await http.get(
        Uri.parse(mainUrl + mainGift),
        headers: {
          _acceptKey: _acceptValue,
        },
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(json.decode(response.body));

        print('user_id: $data');

        List<GiftModel> result = data['ALL Gifts']
            .map<GiftModel>((json) => GiftModel.fromJson(json))
            .toList();

        final user_id = await loadUserID();

        if (user_id != -1) {
          print('user_id: $user_id');
          result = result.where((element) {
            if (element.senderID == null) {
              return false;
            } else if (element.senderID == user_id) {
              return true;
            }
            return false;
          }).toList();
          return result;
        }
        return null;
      }
      if (response.statusCode == 400 || response.statusCode == 422) {
        return null;
      }
    } catch (ex) {
      print('getGiftService()=> ' + ex.toString());
      return null;
    }
    return null;
  }

  // STORE gift OPERATION
  Future<bool> addGiftService(
    GiftModel giftModel,
  ) async {
    var response;

    print('gift Services');
    try {
      response = await http.post(
        Uri.parse(mainUrl + mainGift),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(giftModel.toJson()),
      );
      log(' this response body to add gift  +${response.body.toString()}');
      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      print(' this status code  to gift  ${response.statusCode.toString()}');
    } catch (e) {
      print(' this status code  to gift  ${e.toString()}');

      return false;
    }
    return false;
  }
}
