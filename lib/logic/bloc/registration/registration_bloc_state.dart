// ignore_for_file: prefer_typing_uninitialized_variables

part of 'registration_bloc_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegisterationEmailDublicated extends RegistrationState{
  final  errorEmail;

  const RegisterationEmailDublicated(this.errorEmail);

  @override
  List<Object> get props => [errorEmail];

  @override
  String toString() {
    return 'RegistrationFaliure {error:$errorEmail}';
  }
}

class RegistrationFaliure extends RegistrationState {
  final String error;

  const RegistrationFaliure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'RegistrationFaliure {error:$error}';
  }
}
