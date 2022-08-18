import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'donation_ca_event.dart';
part 'donation_ca_state.dart';

class DonationCaBloc extends Bloc<DonationCaEvent, DonationCaState> {
  DonationCaBloc() : super(DonationCaInitial()) {
    on<DonationCaEvent>((event, emit) {});
  }
}
