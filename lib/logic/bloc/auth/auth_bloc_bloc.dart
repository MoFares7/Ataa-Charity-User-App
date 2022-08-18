import 'package:bloc/bloc.dart';
import 'package:charity_management_system/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(
    this.authRepository,
  ) : super(AuthInitial()) {
    // check if user is already logged in or no
    on<AppStarted>((event, emit) async {
      // get access token from internal storage
      bool isLoggedIn = await authRepository.hasToken();

      if (isLoggedIn) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await authRepository.presistToken(event.token); // store token
      emit(AuthAuthenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await authRepository.deleteToken();
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('email')) {
        await prefs.remove('email');
        await OneSignal.shared.logoutEmail();
      }
      emit(AuthUnauthenticated());
    });
  }
}
