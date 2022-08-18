// ignore_for_file: non_constant_campiganIDentifier_names, non_constant_identifier_names, unnecessary_this

class DonationCa {
  int? campiganID;
  String? name_donation_camp;
  String? name_donation_camp_en;
  String? image_url;
  double? payment_required;
  int? type_camp;
  int? num_of_needy_persons;
  late double remaining_amount;
  final String? status;

  final double? current_amount;

  DonationCa({
    required this.campiganID,
    required this.name_donation_camp,
    required this.name_donation_camp_en,
    required this.image_url,
    required this.payment_required,
    required this.type_camp,
    required this.num_of_needy_persons,
    this.current_amount,
    this.status,
  }) {
    remaining_amount = payment_required! - current_amount!;
  }

  factory DonationCa.fromJson(Map<String, dynamic> json) {
    return DonationCa(
      campiganID: json['id'] as int,
      name_donation_camp: json['name_donation_camp'] as String,
      name_donation_camp_en: json['name_donation_camp_en'] as String,
      image_url: json['image_url'] as String,
      payment_required: double.parse(json['payment_required'].toString()),
      num_of_needy_persons: json['num_of_needy_persons'] as int,
      type_camp: json['type_of_campaign_id'] as int,
      current_amount: double.parse(json['current_amount'].toString()),
      status: json['status'] as String?,
    );
  }

  @override
  String toString() => 'remaining amount ($campiganID) = $remaining_amount';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DonationCa &&
        //other.campiganID == campiganID &&
        other.name_donation_camp == name_donation_camp &&
        other.name_donation_camp_en == name_donation_camp_en &&
        other.image_url == image_url &&
        other.payment_required == payment_required &&
        other.num_of_needy_persons == num_of_needy_persons;
    //other.type_camp == type_camp;
  }

  @override
  int get hashCode =>
      // campiganID.hashCode ^
      name_donation_camp.hashCode ^
      image_url.hashCode ^
      payment_required.hashCode ^
      num_of_needy_persons.hashCode;
// type_camp.hashCode;
}
