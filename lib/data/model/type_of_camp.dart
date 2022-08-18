class TypeOfCampaign {
  final int typeId;
  final String typeNameAr;
  final String typeNameEn;

  const TypeOfCampaign({
    required this.typeId,
    required this.typeNameAr,
    required this.typeNameEn,
  });
}

const typesOfCampaigns = <TypeOfCampaign>[
  TypeOfCampaign(typeId: 1, typeNameAr: 'صحة', typeNameEn: 'Health'),
  TypeOfCampaign(typeId: 2, typeNameAr: 'تعليم', typeNameEn: 'Education'),
  TypeOfCampaign(typeId: 3, typeNameAr: 'ترفيه', typeNameEn: 'Entertainment'),
  TypeOfCampaign(typeId: 4, typeNameAr: 'أخرى', typeNameEn: 'Other'),
];
