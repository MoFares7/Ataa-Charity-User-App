// ignore_for_file: non_constant_identifier_names

part of 'donation_ca_bloc.dart';

abstract class DonationCaEvent extends Equatable {
  const DonationCaEvent();

  @override
  List<Object> get props => [];
}

class DonationButtonPressed extends DonationCaEvent {
  final String name_donation_camp;
  final String imageUrl;
  final String num_of_needy_person;
  final String payment_requier;

  const DonationButtonPressed({
    required this.name_donation_camp,
    required this.imageUrl,
    required this.num_of_needy_person,
    required this.payment_requier,
  });

  @override
  List<Object> get props =>
      [name_donation_camp, imageUrl, num_of_needy_person, payment_requier];

  @override
  String toString() {
    return 'DonationButtonPressed {name_donation_camp: $name_donation_camp, imageUrl: $imageUrl, num_of_needy_person: $num_of_needy_person, payment_requier: $payment_requier}';
  }
}
