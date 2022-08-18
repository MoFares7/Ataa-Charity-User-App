part of 'login_bloc_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginButtonPressed {email: $email, password: $password}';
  }
}

class LoginWithGooglePressed extends LoginEvent {
  final String token;

  const LoginWithGooglePressed({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() {
    return 'LoginWithGooglePressed {$token}';
  }
}
