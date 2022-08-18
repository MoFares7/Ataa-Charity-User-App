// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class User {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? password;
  User({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.password,
  });

  User copyWith({
    int? id,
    String? first_name,
    String? last_name,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      first_name: map['first_name'],
      last_name: map['last_name'],
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() =>
      'User(id: $id, first_name: $first_name, email: $email , password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      email.hashCode ^
      password.hashCode;
}
