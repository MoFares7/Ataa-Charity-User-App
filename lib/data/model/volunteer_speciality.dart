class VolunteerSpeciality {
  final int? id;
  final String? titleAr;
  final String? titleEn;

  const VolunteerSpeciality({
    this.id,
    this.titleAr,
    this.titleEn,
  });

  // FROM JSON METHOD WITH DATETIME FORMATTED INTO TIMES
  factory VolunteerSpeciality.fromJson(Map<String, dynamic> json) {
    return VolunteerSpeciality(
      id: json['id'] as int,
      titleAr: json['name'] as String,
      titleEn: json['name_en'] as String,
    );
  }
}
