// ignore_for_file: non_constant_identifier_names

part of 'registration_bloc_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegistrationEvent {
  final String first_name;
  final String last_name;
  final String email;
  final String password;

  const RegisterButtonPressed({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password,
  });
}

class RegisterEmailDublicated extends RegistrationEvent {
  final String first_name;
  final String last_name;
  final String email;
  final String password;

  const RegisterEmailDublicated({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [first_name, last_name, email, password];

  @override
  String toString() {
    return 'RegistrationButtonPressed {first_name: $first_name, last_name: $last_name, email: $email, password: $password}';
  }
}
