// ignore_for_file: non_constant_identifier_names, unnecessary_this
class GiftModel {
  int? person_with_special_need_id;
  String sender_name;
  String sender_phone;
  String amount_paid;
  String payment_method_id;

  GiftModel({
    required this.person_with_special_need_id,
    required this.sender_name,
    required this.sender_phone,
    required this.amount_paid,
    required this.payment_method_id,
  });

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      person_with_special_need_id: json['person_with_special_need_id'] as int,
      sender_name: json['sender_name'] as String,
      sender_phone: json['sender_phone'] as String,
      amount_paid: json['amount'] as String,
      payment_method_id: json['payment_method_id'] as String,
    );
  }

  GiftModel copyWith({
    int? person_with_special_need_id,
    String? sender_name,
    String? sender_phone,
    String? amount_paid,
    String? payment_method_id,
    //String? amount_paid,
  }) {
    return GiftModel(
      person_with_special_need_id:
          person_with_special_need_id ?? this.person_with_special_need_id,
      sender_name: sender_name ?? this.sender_name,
      sender_phone: sender_phone ?? this.sender_phone,
      amount_paid: amount_paid ?? this.amount_paid,
      payment_method_id: payment_method_id ?? this.payment_method_id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person_with_special_need_id': person_with_special_need_id,
      'sender_name': sender_name,
      'sender_phone': sender_phone,
      'amount': amount_paid,
      'payment_method_id': payment_method_id,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'person_with_special_need_id': person_with_special_need_id,
      'sender_name': sender_name,
      'sender_phone': sender_phone,
      'amount': amount_paid,
      'payment_method_id': payment_method_id,
      //'type_of_campaign_id': amount_paid,
    };
  }

  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      person_with_special_need_id: map['person_with_special_need_id'],
      sender_name: map['sender_name'],
      sender_phone: map['sender_phone'],
      amount_paid: map['amount'],
      payment_method_id: map['payment_method_id'],
    );
  }

  @override
  String toString() =>
      'AddDonationOperation(person_with_special_need_id: $person_with_special_need_id, sender_name: $sender_name , sender_phone: $sender_phone, amount :$amount_paid ,payment_method_id :$payment_method_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftModel &&
        //other.id == id &&
        other.person_with_special_need_id == person_with_special_need_id &&
        other.sender_name == sender_name &&
        other.sender_phone == sender_phone &&
        other.amount_paid == amount_paid &&
        other.payment_method_id == payment_method_id;
  }

  @override
  int get hashCode =>
      // id.hashCode ^
      person_with_special_need_id.hashCode ^
      sender_name.hashCode ^
      sender_phone.hashCode ^
      amount_paid.hashCode ^
      payment_method_id.hashCode;

  // TO JSON FUNCTION

}
