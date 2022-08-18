class Statistics {
  final double? totalDonation;
  final int? tottalNumberOfVolunteer;
  final int? countOfCharityActivities;
  final int? numberOfPersonWithSpecialNeeds;

  Statistics({
    this.totalDonation,
    this.tottalNumberOfVolunteer,
    this.countOfCharityActivities,
    this.numberOfPersonWithSpecialNeeds,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        totalDonation: double.parse(json['Total Donations'].toString()),
        countOfCharityActivities: int.parse(json['Volunteer '].toString()),
        // countOfDeliveredGifts: json['Gifts '] as int,
        tottalNumberOfVolunteer:
            int.parse(json['Number Of Volunteer '].toString()),
        numberOfPersonWithSpecialNeeds:
            int.parse(json['Person With Special Need'].toString()),
      );
}
