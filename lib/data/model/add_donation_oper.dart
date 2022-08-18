// ignore_for_file: non_constant_identifier_names, unnecessary_this
import 'package:charity_management_system/data/model/donation_ca.dart';

class AddDonationOperation {
  final int? id;
  final int? user_id;
  int? donation_campaign_id;
  String payment_method_id;
  String amount_paid;
  final DonationCa? donationCampaign;
  final DateTime? paymentDate;

  AddDonationOperation({
    this.id,
    required this.user_id,
    required this.donation_campaign_id,
    required this.payment_method_id,
    required this.amount_paid,
    this.donationCampaign,
    this.paymentDate,
  });

  factory AddDonationOperation.fromJson(Map<String, dynamic> json) {
    return AddDonationOperation(
      id: int.parse(json['id'].toString()),
      user_id: json['user_id'] == null
          ? null
          : int.parse(json['user_id'].toString()),
      donation_campaign_id: int.parse(json['donation_campaign_id'].toString()),
      payment_method_id: json['payment_method_id'].toString(),
      amount_paid: json['amount_paid'].toString(),
      donationCampaign: json['donationcampaign'] != null
          ? DonationCa.fromJson(json['donationcampaign'])
          : null,
      paymentDate: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'donation_campaign_id': donation_campaign_id,
      'payment_method_id': 2,
      'amount_paid': amount_paid,
    };
  }

  @override
  String toString() =>
      'AddDonationOperation(user_id: $user_id, donation_campaign_id: $donation_campaign_id , payment_method_id: $payment_method_id, amount_paid :$amount_paid )';
}
