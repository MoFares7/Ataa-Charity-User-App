// ignore_for_file: unused_field, non_constant_identifier_names, avoid_print, constant_identifier_names, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable
import 'dart:convert';
import 'dart:developer';

import 'package:charity_management_system/data/model/add_vlounteer.dart';
import 'package:charity_management_system/data/model/volunter_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../configs/helpers.dart';

// ignore: camel_case_types
class VolunterServices {
  //static const mainUrl = 'http://192.168.43.29:8000/api';
  static const volunterCampUrl = '/volunteer-campaign/';
  static const addVounterUrl = '/volunteer';

  // Accept header value
  static const _acceptValue = 'application/json';
  static const _acceptKey = 'Accept';
  static const _authorizationKey = 'Authorization';

  late Map jsondata;

  static Future<List<VolunteerModel>?> getVolunterService() async {
    var response;
    try {
      response = await http.get(
        Uri.parse(mainUrl + volunterCampUrl),
        headers: {
          _acceptKey: _acceptValue,
        },
      );

      if (response.statusCode == 200) {
        var result;
        try {
          final data = Map<String, dynamic>.from(json.decode(response.body));
          final userID = await loadUserID();
          result =
              (data['Volunteers Campaign'] as List).map<VolunteerModel>((json) {
            final model = VolunteerModel.fromJson(json);
            try {
              model.isMeIncluded = model.volunteers == null
                  ? false
                  : model.volunteers!.isEmpty
                      ? false
                      : model.volunteers!
                          .any((element) => element.user_id == userID);
              return model;
            } catch (e) {
              print('error in getting volunteer ()=> $e');
            }
            return model;
          }).toList();
        } catch (e) {
          print(
              'VolunterServices: getVolunterService: result: ${e.toString()}');
        }
        print(
            ' this status code  to get Volunteer aaaaaaaaaaaaaaaaaaaaaaaa  ${response.statusCode.toString()}');
        log(' this response to get response vvvvvvvvvvvvv body to gift  +${response.body.toString()}');

        return result;
      }
      if (response.statusCode == 400 || response.statusCode == 422) {
        return null;
      }
    } catch (ex) {
      return null;
    }
    return null;
  }

  static Future<List<AddVolunteerModel>?> getMyVolunteerRequests(
      int userID) async {
    var response;
    try {
      response = await http.get(
        Uri.parse(mainUrl + addVounterUrl + '/$userID'),
        headers: {
          _acceptKey: _acceptValue,
        },
      );
      if (response.statusCode == 200) {
        var result;
        try {
          final data = Map<String, dynamic>.from(json.decode(response.body));
          result = (data['Volunteers'] as List)
              .map<AddVolunteerModel>(
                  (json) => AddVolunteerModel.fromJson(json))
              .toList();
        } catch (e) {
          print(
              'VolunterServices: getVolunterService: result: ${e.toString()}');
        }
        return result;
      }
      if (response.statusCode == 400 || response.statusCode == 422) {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

  static Future<List<VolunteerModel>?> getVolunterDetailsService() async {
    var response;
    try {
      response = await http.get(
        Uri.parse(mainUrl + volunterCampUrl),
        headers: {
          _acceptKey: _acceptValue,
        },
      );

      if (response.statusCode == 200) {
        print(
            ' this status code  to get Volunteer aaaaaaaaaaaaaaaaaaaaaaaa  ${response.statusCode.toString()}');
        print(
            ' this response to get response 11111111111111111111 body to gift  +${response.body.toString()}');

        final data = Map<String, dynamic>.from(json.decode(response.body));

        final result = data['Volunteers Campaign']
            .map<VolunteerModel>((json) => VolunteerModel.fromJson(json))
            .toList();

        return result;
      }
      print(' this response 22222222222222222  +${response.body.toString()}');
      if (response.statusCode == 400 || response.statusCode == 422) {
        return null;
      }
    } catch (ex) {
      return null;
    }
    return null;
  }

  static Future<bool> addVolunteerServices(AddVolunteerModel volunteer) async {
    // SEND A MULTIPART FORM DATA REQUEST TO APPEND CERTIFICATE FILE WITH REQUEST BODY
    const fullUrl = '$mainUrl$addVounterUrl';
    final data = volunteer.toJson();
    final Dio _dio = Dio();
    data['certificate_url'] = await MultipartFile.fromFile(
      volunteer.certificateFile!.path,
      filename: basename(volunteer.certificateFile!.path),
    );
    FormData formData = FormData.fromMap(data);
    print('this data volunteer' + data.toString());
    try {
      final response = await _dio.post(
        fullUrl,
        data: formData,
        options: Options(
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      print(' " this status code to add volunteer final' 
          '' +
          response.statusCode.toString());

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
        throw http.ClientException('Failed to store volunteer');

        // ! ERROR CAUSED BY USER'S REQUEST
      } else {
        throw http.ClientException('Failed to add volunteer');
      }
    } catch (ex) {
      throw Exception(' this error in add volunteer ' + ex.toString());
    }
  }
}
