class JobPosition {
  final int typeId;
  final String typeNameAr;

  const JobPosition({
    required this.typeId,
    required this.typeNameAr,
  });
}

const jobPosition = <JobPosition>[
  JobPosition(
    typeId: 1,
    typeNameAr: 'مدير عام',
  ),
  JobPosition(
    typeId: 2,
    typeNameAr: 'مدير مبيعات',
  ),
  JobPosition(
    typeId: 3,
    typeNameAr: 'مدير المشتريات',
  ),
  JobPosition(
    typeId: 4,
    typeNameAr: 'عامل',
  ),
  JobPosition(
    typeId: 5,
    typeNameAr: 'موظف',
  ),
  JobPosition(
    typeId: 6,
    typeNameAr: 'موظف',
  ),
  JobPosition(
    typeId: 7,
    typeNameAr: 'رئيس قسم',
  ),
  JobPosition(
    typeId: 8,
    typeNameAr: 'عامل',
  ),
  JobPosition(
    typeId: 9,
    typeNameAr: 'محاسب',
  ),
  JobPosition(
    typeId: 10,
    typeNameAr: 'مهندس',
  ),
];
