// ignore_for_file: non_constant_identifier_names, unnecessary_this
class Person {
  int? id;
  String? f_name;
  String? l_name;

  late String fullname;

  Person({
    required this.id,
    required this.f_name,
    required this.l_name,
  }) {
    fullname = f_name! + ' ' + l_name!;
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as int,
      f_name: json['f_name'] as String,
      l_name: json['l_name'] as String,
    );
  }

  Person copyWith({
    int? id,
    String? f_name,
    String? l_name,
  }) {
    return Person(
      id: id ?? this.id,
      f_name: f_name ?? this.f_name,
      l_name: l_name ?? this.l_name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': f_name,
      'l_name': l_name,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'f_name': f_name,
      'l_name': l_name,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      f_name: map['f_name'],
      l_name: map['l_name'],
    );
  }
}
