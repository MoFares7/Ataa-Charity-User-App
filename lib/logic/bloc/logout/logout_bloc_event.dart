part of 'logout_bloc_bloc.dart';

abstract class LogoutBlocEvent extends Equatable {
  const LogoutBlocEvent();

  @override
  List<Object> get props => [];
}

class LogoutEventPressed extends LogoutBlocEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'LoginButtonPressed.';
  }
}
