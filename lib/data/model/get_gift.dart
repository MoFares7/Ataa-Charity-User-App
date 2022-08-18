// ignore_for_file: non_constant_identifier_names, unnecessary_this
class GiftModel {
  
  // Needed For Sending POST REQUEST
  final int? id;
  final int? senderID;
  final int? personID;
  String? senderName;
  String? senderPhone;
  final String? recipientName;
  double? giftValue;
  String? giftDescription; // Optional
  String? payment_method_id; // A CONSTANT WITH VALUE OF 2 ALWAYS

  // Needed for GET REQUEST
  String? deliveryDate;
  final bool? isDelivered;

  GiftModel({
    this.id,
    this.senderID,
    this.personID,
    this.senderName,
    this.senderPhone,
    this.recipientName,
    this.giftValue,
    this.giftDescription,
    this.payment_method_id,
    this.deliveryDate,
    this.isDelivered,
  });

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      id: json['id'] as int,
      senderID: json['user_id'] == null ? null : json['user_id'] as int,
      senderName: json['sender_name'] as String?,
      recipientName:
          ('${json['person']['f_name']} ${json['person']['l_name']}'),
      giftValue: double.parse(json['amount'].toString()),
      giftDescription: json['description'] as String?,
      deliveryDate: json['updated_at'] as String?,
      isDelivered: int.parse(json['delivered'].toString()) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': senderID,
      'person_with_special_need_id': personID,
      'sender_name': senderName,
      'sender_phone': senderPhone,
      'amount': giftValue,
      'description': giftDescription,
      'payment_method_id': 2,
    };
  }

  // TO STRING
  @override
  String toString() {
    return 'GiftModel{id: $id, senderID: $senderID, personID: $personID, senderName: $senderName, senderPhone: $senderPhone, recipientName: $recipientName, giftValue: $giftValue, giftDescription: $giftDescription, payment_method_id: $payment_method_id, deliveryDate: $deliveryDate, isDelivered: $isDelivered}';
  }
}
