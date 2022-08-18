// ignore_for_file: non_constant_identifier_names, unnecessary_this, unused_local_variable

import 'dart:io';

import 'package:charity_management_system/data/model/volunter_model.dart';
import 'package:easy_localization/easy_localization.dart';

class AddVolunteerModel {
  int? id;
  int? user_id;
  int? volunteer_campaign_id;
  String? f_name;
  String? l_name;
  DateTime? brithdate;
  String? exp_years;
  String? phone_num;
  String? univarcity_degree;
  String? email;
  DateTime? joinDate;
  File? certificateFile;
  int? accepted;
  final VolunteerModel? volunteerCampaign;

  AddVolunteerModel({
    this.joinDate,
    this.certificateFile,
    this.id,
    this.user_id,
    this.volunteer_campaign_id,
    this.f_name,
    this.l_name,
    this.brithdate,
    this.exp_years,
    this.phone_num,
    this.email,
    this.univarcity_degree,
    this.accepted,
    this.volunteerCampaign,
  }) {
    String fullName = '$f_name $l_name';
    var status = _getStatus();
  }

  // TO JSON
  Map<String, dynamic> toJson() => {
        "f_name": f_name,
        "l_name": l_name,
        "user_id": user_id,
        "volunteer_campaign_id": volunteer_campaign_id,
        "birthdate": brithdate == null
            ? null
            : DateFormat('yyyy-MM-dd').format(brithdate!),
        "email": email,
        "phone_num": phone_num,
        "university_degree": univarcity_degree,
        "experience_year": exp_years,
        "start_date": DateFormat('yyyy-MM-dd').format(joinDate!),
      };

  factory AddVolunteerModel.fromJson(Map<String, dynamic> json) {
    return AddVolunteerModel(
      user_id: json['user_id'],
      volunteer_campaign_id: json['volunteer_campaign_id'],
      accepted: json['accepted'],
      volunteerCampaign: json['volunteer_campaign'] == null
          ? null
          : VolunteerModel.fromJson(json['volunteer_campaign']),
    );
  }
}

_getStatus() {
  // ignore: prefer_typing_uninitialized_variables
  var statusInt;
  if (statusInt == null) {
    return null;
  }
  switch (statusInt) {
    case 2:
      return VolunteerStatus.pending;
    case 1:
      return VolunteerStatus.accepted;
    case 0:
      return VolunteerStatus.rejected;
    default:
      return null;
  }
}

enum VolunteerStatus {
  pending,
  accepted,
  rejected,
}
