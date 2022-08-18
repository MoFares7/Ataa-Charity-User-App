class PageBanner {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;

  PageBanner(this.id, this.title, this.subtitle, this.imageUrl);
}

// simple data
List<PageBanner> pageBannerList = [
  PageBanner(
      1,
      "فرص تبرع متنوعة",
      "تغطي كافة مجالات الخير والاحتياج وتصل إلى من يستحقها من الحالات الأشد احتياجا",
      'assets/images/opportunities.png'),
  PageBanner(
      3,
      "وسائل دفع مختلفة ",
      "التبرع بسهولة تامة من خلال وسائل الدفع الإلكتروني المتنوعة التي يدعمها التطبيق ",
      'assets/images/payment_services.png'),
  PageBanner(
      2,
      "فرص تطوع عديدة ",
      "اختيار أحد فرص التطوع المتاحة بما يناسب إمكانيات المتقدم وتقديم طلب التطوع بسهولة تامة",
      'assets/images/donation_card.png'),
];
