// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks, avoid_print, unused_local_variable, avoid_unnecessary_containers
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/data/content/total_ataa.dart';
import 'package:charity_management_system/data/content/volunteer_services.dart';
import 'package:charity_management_system/data/model/type_of_camp.dart';
import 'package:charity_management_system/data/model/volunter_model.dart';
import 'package:charity_management_system/model/carousel_items.dart';
import 'package:charity_management_system/view/controllers/payment_controllers.dart';
import 'package:charity_management_system/view/screens/donation_camigan_screen/donation_campigan_screen.dart';
import 'package:charity_management_system/view/screens/gift_screen/gift_main_screen.dart';
import 'package:charity_management_system/view/screens/home_screen/ataa_number.dart';
import 'package:charity_management_system/view/screens/home_screen/card_donation.dart';
import 'package:charity_management_system/view/screens/home_screen/carousel.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/main_mune_volunteer_screen.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/volunter_campign_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/helpers.dart';
import '../../../data/content/donation_service.dart';
import '../../../data/model/donation_ca.dart';
import '../../../data/model/statistics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = 'Home_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = CarouselController();
  int activeIndex = 0;
  bool isEngilsh = true;
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Donation_Ca_service? donationCaService;
    final PaymentController controller = Get.put(PaymentController());
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: Theme.of(context).progressIndicatorTheme.color,
          onRefresh: () async {
            setState(() {
              Donation_Ca_service.donationUrl;
              VolunterServices.getVolunterService;
              TotalAtaaServices.getTotalAtaaService();
              // fitchDataDonation(size);
            });
          },
          //? List io All Data
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    //? create carsoul
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        reverse: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      itemCount: 2,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return CreateCarousel(
                          imageUrl2: imageUrl[0],
                          index: index,
                          title: title[index],
                          subTitle: subTitle[index],
                          onTap: () {
                            if (index == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MainMuneVolunteerScreen()),
                              );
                            } else if (index == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MainMenuGift()),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr('donation campign'),
                          style: TextStyle(
                              fontSize: 12.sp,
                              // color: AppColors.primary1,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DonationCampiganScreen()));
                          },
                          child: Text(
                            tr('more'),
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: Theme.of(context).iconTheme.color,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 3,
                        vertical: defaultPadding * 2,
                      ),
                      //! now logic Donation Campiagn
                      child: FutureBuilder<List<DonationCa>?>(
                          future: Donation_Ca_service.donationUser(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              print(snapshot.hasData.toString());
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 7,
                                width: MediaQuery.of(context).size.width / 3,
                                child: Center(
                                  child: Lottie.asset('assets/animation.json',
                                      animate: true),
                                ),
                              );
                            }
                            //? if sucsess fetch data will show here
                            if (snapshot.hasData) {
                              List<DonationCa> donationCa =
                                  snapshot.data as List<DonationCa>;
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.9,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: donationCa.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: CardsDonaition(
                                        campiganID:
                                            donationCa[index].campiganID,
                                        image_url: donationCa[index]
                                            .image_url
                                            .toString(),
                                        payment_required:
                                            Helpers.getMoneyAmount(
                                                donationCa[index]
                                                    .payment_required!),
                                        remember: Helpers.getMoneyAmount(
                                            double.parse(donationCa[index]
                                                .remaining_amount
                                                .toStringAsFixed(1))),
                                        num_of_needy_person: donationCa[index]
                                            .num_of_needy_persons,
                                        name_donation_camp:
                                            context.locale == const Locale('ar')
                                                ? donationCa[index]
                                                    .name_donation_camp
                                                    .toString()
                                                : donationCa[index]
                                                    .name_donation_camp_en
                                                    .toString(),
                                        type_camp: context.locale ==
                                                const Locale('ar')
                                            ? typesOfCampaigns
                                                .where((element) =>
                                                    element.typeId ==
                                                    donationCa[index].type_camp)
                                                .first
                                                .typeNameAr
                                            : typesOfCampaigns
                                                .where((element) =>
                                                    element.typeId ==
                                                    donationCa[index].type_camp)
                                                .first
                                                .typeNameEn,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return const SizedBox();
                          })),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr('Volunteer Campaigns'),
                          style: TextStyle(
                              fontSize: 12.sp,
                              //  color: AppColors.primary1,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const VolunterCampignScreen()));
                          },
                          child: Text(
                            tr('more'),
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: Theme.of(context).iconTheme.color,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 3),
                    child: FutureBuilder<List<VolunteerModel>?>(
                      future: VolunterServices.getVolunterService(),
                      builder: (context, snapshot) {
                        print('getVolunterService()=> ${snapshot.hasData}');
                        if (!snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 7,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Center(
                              child: Lottie.asset('assets/animation.json',
                                  animate: true),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          List<VolunteerModel> volunteerCamp =
                              snapshot.data as List<VolunteerModel>;
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: volunteerCamp.length,
                              itemBuilder: (context, index) {
                                return Row(children: [
                                  VolunteerDonation(
                                    size: size,
                                    image: volunteerCamp[index].image_url,
                                    title: context.locale == const Locale('ar')
                                        ? volunteerCamp[index].name_vol_cam
                                        : volunteerCamp[index].name_vol_cam_en,
                                  ),
                                  const SizedBox(
                                    width: defaultPadding,
                                  ),
                                ]);
                              },
                            ),
                          );
                        }

                        return Container();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 1.5,
                  ),
                  FutureBuilder<Statistics?>(
                    future: TotalAtaaServices.getTotalAtaaService(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AtaaNumbers(
                          size: size,
                          countOfCharityActivities:
                              snapshot.data!.countOfCharityActivities,
                          numberOfPersonWithSpecialNeeds:
                              snapshot.data!.numberOfPersonWithSpecialNeeds,
                          totalDonation: snapshot.data!.totalDonation,
                          tottalNumberOfVolunteer:
                              snapshot.data!.tottalNumberOfVolunteer,
                        );
                      } else {
                        if (!snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 7,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Center(
                              child: Lottie.asset('assets/animation.json',
                                  animate: true),
                            ),
                          );
                        }
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Image.asset(
                    "assets/images/ataa.png",
                    height: 80,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class VolunteerDonation extends StatelessWidget {
  const VolunteerDonation({
    Key? key,
    required this.size,
    required this.image,
    required this.title,
  }) : super(key: key);

  final Size size;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      //width: size.width / 1.7,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SizedBox(
            height: size.height / 4,
            width: size.width / 1.7,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: '$baseUrl$image',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Text(
            title.trimRight(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
          )
        ],
      ),
    );
  }
}
