part of 'logout_bloc_bloc.dart';

abstract class LogoutBlocState extends Equatable {
  const LogoutBlocState();

  @override
  List<Object> get props => [];
}

class LogoutBlocInitial extends LogoutBlocState {}

class LogoutBlocFailur extends LogoutBlocState {
  final String error;
  const LogoutBlocFailur(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'LogoutFaliure {error:$error}';
  }
}

class LogoutBlocLoding extends LogoutBlocState {}
