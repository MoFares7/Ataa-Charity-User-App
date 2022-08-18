// ignore_for_file: non_constant_identifier_names, unnecessary_this
class SpeedDonation {
  
  int donation_campaign_id;
  int payment_method_id;
  double amount_paid;
  String donor_name;
  String? phone_number_donation;

  SpeedDonation({
    required this.donor_name,
    required this.donation_campaign_id,
    required this.payment_method_id,
    required this.amount_paid,
    this.phone_number_donation,
  });

  factory SpeedDonation.fromJson(Map<String, dynamic> json) {
    return SpeedDonation(
      donor_name: json['donor_name'] as String,
      donation_campaign_id: json['donation_campaign_id'] as int,
      payment_method_id: json['payment_method_id'] as int,
      amount_paid:double.parse( json['amount_paid'].toString()),
      phone_number_donation: json['phone'] as String,
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
      'donor_name': donor_name,
      'donation_campaign_id': donation_campaign_id,
      'payment_method_id': 2,
      'amount_paid': amount_paid.toString(),
      'phone': phone_number_donation,
    };
  }

  @override
  String toString() =>
      'AddDonationOperation(donor_name: $donor_name, donation_campaign_id: $donation_campaign_id , payment_method_id: $payment_method_id, amount_paid :$amount_paid )';


}
