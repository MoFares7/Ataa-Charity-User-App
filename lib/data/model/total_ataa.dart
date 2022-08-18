// ignore_for_file: non_constant_identifier_names, unnecessary_this
class TotalAtaaModel {
  //int? person_with_special_need_id;
  int donations;
  int volunteer;
  int number_of_volunteer;
  int person_with_special_need;
  int gift;

  TotalAtaaModel({
    required this.donations,
    required this.volunteer,
    required this.number_of_volunteer,
    required this.person_with_special_need,
    required this.gift,
  });

  factory TotalAtaaModel.fromJson(Map<int, dynamic> json) {
    return TotalAtaaModel(
      donations: json['Donations'] as int,
      volunteer: json['Volunteer'] as int,
      number_of_volunteer: json['Number Of Volunteer'] as int,
      person_with_special_need: (json['Person With Special Need'] as int),
      gift: json['Gifts'] as int,
    );
  }

  TotalAtaaModel copyWith({
    int? person_with_special_need_id,
    int? donations,
    int? volunteer,
    int? amount_paid,
    int? person_with_special_need,
    int? gift,
    //String? amount_paid,
  }) {
    return TotalAtaaModel(
      // person_with_special_need_id:
      // person_with_special_need_id ?? this.person_with_special_need_id,
      donations: donations ?? this.donations,
      volunteer: volunteer ?? this.volunteer,
      number_of_volunteer: number_of_volunteer,
      person_with_special_need:
          person_with_special_need ?? this.person_with_special_need,
      gift: gift ?? this.gift,
    );
  }
}
