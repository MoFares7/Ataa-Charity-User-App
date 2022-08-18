class Day {
  int id;
  String nameAr;
  String nameEn;

  Day({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  // FROM JSON METHOD
  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'] as int,
      nameAr: json['day'] as String,
      nameEn: json['day_en'] as String,
    );
  }

  factory Day.matchID(int id) {
    return weekDays.where((element) => element.id == id).first;
  }

  // TO JSON METHOD
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': nameAr,
      'day_en': nameEn,
    };
  }
}

final List<Day> weekDays = [
  Day(id: 1, nameAr: 'السبت', nameEn: 'Saturday'),
  Day(id: 2, nameAr: 'الأحد', nameEn: 'Sunday'),
  Day(id: 3, nameAr: 'الاثنين', nameEn: 'Monday'),
  Day(id: 4, nameAr: 'الثلاثاء', nameEn: 'Tuesday'),
  Day(id: 5, nameAr: 'الأربعاء', nameEn: 'Wednesday'),
  Day(id: 6, nameAr: 'الخميس', nameEn: 'Thursday'),
  Day(id: 7, nameAr: 'الجمعة', nameEn: 'Friday'),
];
