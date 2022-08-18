// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:charity_management_system/data/repositories/auth_repository.dart';
import 'package:charity_management_system/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/shared/shared_prefs_repository.dart';

part 'logout_bloc_event.dart';
part 'logout_bloc_state.dart';

class LogoutBloc extends Bloc<LogoutBlocEvent, LogoutBlocState> {
  final AuthRepository authRepository;
  final AuthBloc authBloc;
  final SharedPrefsRepository sharedPrefsRepository;
  LogoutBloc(
      {required this.authRepository,
      required this.authBloc,
      required this.sharedPrefsRepository})
      : super(LogoutBlocInitial()) {
    on<LogoutEventPressed>((event, emit) async {
      emit(LogoutBlocLoding());

      try {
        final token = await sharedPrefsRepository.getAccessToken();
        print('LogoutEventPressed()=> $token');
        if (token == null) {
          throw Exception('The token is not Founded');
        }

        // if token was found delete it
        final message = await authRepository.logout(token);
        if (message == null) {
          throw Exception('Error while deleting token');
        }
        authBloc.add(LoggedOut());
        emit(LogoutBlocInitial());
      } catch (ex) {
        emit(LogoutBlocFailur(ex.toString()));
      }
    });
  }
}
