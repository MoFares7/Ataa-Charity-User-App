import 'package:bloc/bloc.dart';
import 'package:charity_management_system/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../auth/auth_bloc_bloc.dart';

part 'registration_bloc_event.dart';
part 'registration_bloc_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;

  RegistrationBloc({
    required AuthRepository authRepository,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _authRepository = authRepository,
        super(RegistrationInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegistrationLoading());
      try {
        final token = await _authRepository.register(
          event.first_name,
          event.last_name,
          event.email,
          event.password,
        );
        if (token == null) {
          throw Exception('Error while create Account');
        }
        _authBloc.add(LoggedIn(token));
        emit(RegistrationInitial());
      } catch (ex) {
        emit(RegistrationFaliure(ex.toString()));
      }
    });

    on<RegisterEmailDublicated>((event, emit)async {
       emit(RegistrationLoading());
      try {
        final token = await _authRepository.register(
          event.first_name,
          event.last_name,
          event.email,
          event.password,
        );
        if (token == null) {
          throw Exception('Error while create Account');
        }
        _authBloc.add(LoggedIn(token));
        emit(RegistrationInitial());
      } catch (ex) {
        emit(RegisterationEmailDublicated(ex.toString()));
      }
    });
    }
    
  }

