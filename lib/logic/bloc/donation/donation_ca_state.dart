part of 'donation_ca_bloc.dart';

abstract class DonationCaState extends Equatable {
  const DonationCaState();

  @override
  List<Object> get props => [];
}

class DonationCaInitial extends DonationCaState {}

class DonationCaLoadining extends DonationCaState {}

class DonationCaSuccsess extends DonationCaState {}

class DonationCaFailuer extends DonationCaState {
  final String error;

  const DonationCaFailuer(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'RegistrationFaliure {error:$error}';
  }
}
