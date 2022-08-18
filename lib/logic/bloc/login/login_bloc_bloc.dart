// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:charity_management_system/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/auth_repository.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthBloc authBloc;

  LoginBloc({required this.authRepository, required this.authBloc})
      : super(LoginInitial()) {
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
    // implement login functionality
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      // send request
      try {
        final token = await authRepository.login(
          event.email,
          event.password,
        );

        print('user token: $token');
        if (token == null) {
          throw Exception('Error while fetching token');
        }
        authBloc.add(LoggedIn(token));
        emit(LoginInitial());
      } catch (ex) {
        emit(LoginFaliure(ex.toString()));
      }
    });
  }

  Future<void> _onLoginWithGooglePressed(
    LoginWithGooglePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginGoogleLoading());
    try {
      final token = await authRepository.loginWithGoogle(event.token);
      if (token == null) {
        throw Exception('Error while fetching token');
      }
      emit(LoginSucceed());
      authBloc.add(LoggedIn(token));
      emit(LoginInitial());
    } catch (ex) {
      emit(LoginFaliure(ex.toString()));
    }
  }
}
