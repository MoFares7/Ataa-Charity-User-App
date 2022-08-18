// ignore_for_file: non_constant_campiganIDentifier_names, non_constant_identifier_names, unnecessary_this

import 'package:charity_management_system/data/model/add_vlounteer.dart';
import 'package:charity_management_system/data/model/day_volunteer.dart';
import 'package:charity_management_system/data/model/volunteer_speciality.dart';

class VolunteerModel {
  int id;
  int volunteer_specialty_id;
  String name_vol_cam;
  String name_vol_cam_en;
  String image_url;
  int num_of_vol;
  String? startDate;
  String? endDate;
  String? startTimeDate;
  String? endTimeDate;
  int activity_duration;
  final List<AddVolunteerModel>? volunteers;
  final VolunteerSpeciality? volunteerSpeciality;
  List<Day>? activityDays;
  final int? currentNumberOfVolunteers;
  late bool? isMeIncluded;

  VolunteerModel({
    required this.id,
    required this.volunteer_specialty_id,
    required this.name_vol_cam,
    required this.name_vol_cam_en,
    required this.image_url,
    required this.num_of_vol,
    required this.startDate,
    required this.startTimeDate,
    required this.endTimeDate,
    this.activityDays,
    this.currentNumberOfVolunteers,
    this.endDate,
    this.volunteers,
    required this.activity_duration,
    this.volunteerSpeciality,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      id: json['id'] as int,
      volunteer_specialty_id: json['volunteer_specialty_id'] as int,
      name_vol_cam: json['name_vol_cam'] as String,
      name_vol_cam_en: json['name_vol_cam_en'] as String,
      image_url: json['image_url'] as String,
      num_of_vol: json['num_of_vol'] as int,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      startTimeDate: json['start_time'] as String?,
      endTimeDate: json['end_time'] as String?,
      activity_duration: json['activity_duration'] as int,
      currentNumberOfVolunteers: json['num_of_volunteer'] as int?,
      volunteers: json['volunteer'] == null
          ? null
          : (json['volunteer'] as List<dynamic>)
              .map((e) => AddVolunteerModel.fromJson(e))
              .toList(),
      volunteerSpeciality: json['volunteerspecialty'] == null
          ? null
          : VolunteerSpeciality.fromJson(json['volunteerspecialty']),
      activityDays: json['campaign_day'] == null
          ? null
          : (json['campaign_day'] as List)
              .map<Day>((e) => Day.matchID(e['day_id']))
              .toList(),
    );
  }

  // TO STRING
  @override
  String toString() {
    return 'VolunteerModel{id: $id, volunteer_specialty_id: $volunteer_specialty_id, name_vol_cam: $name_vol_cam, name_vol_cam_en: $name_vol_cam_en, image_url: $image_url, num_of_vol: $num_of_vol, startDate: $startDate, endDate: $endDate, startTimeDate: $startTimeDate, endTimeDate: $endTimeDate, activity_duration: $activity_duration, volunteers: $volunteers, volunteerSpeciality: $volunteerSpeciality, activityDays: $activityDays, currentNumberOfVolunteers: $currentNumberOfVolunteers, isMeIncluded: $isMeIncluded}';
  }
}
