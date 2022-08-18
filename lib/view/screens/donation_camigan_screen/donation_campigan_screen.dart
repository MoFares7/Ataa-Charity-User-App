// ignore_for_file: avoid_print, non_constant_identifier_names, avoid_unnecessary_containers
import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/data/content/donation_service.dart';
import 'package:charity_management_system/view/widgets/search_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../data/model/donation_ca.dart';
import '../../../data/model/type_of_camp.dart';
import '../../widgets/shimmer.dart';
import 'campigin_don.dart';

class DonationCampiganScreen extends StatefulWidget {
  const DonationCampiganScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DonationCampiganScreen> createState() => _DonationCampiganScreenState();
}

class _DonationCampiganScreenState extends State<DonationCampiganScreen> {
  final ValueNotifier<String?> _searchText = ValueNotifier<String?>(null);
  final ValueNotifier<bool> refresh = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    Widget buildMovieShimmer() => ListTile(
          //leading: const CustomWidget.rectangular(height: 64, width: 64),
          title: Align(
            alignment: Alignment.center,
            child: CustomWidget.rectangular(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width * 3,
            ),
          ),

          subtitle: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomWidget.rectangular(
              height: 14,
              width: 300,
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'donation campign'.tr(),
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: refresh,
        builder: (context, isRefreshing, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  defaultPadding,
                  defaultPadding,
                  defaultPadding,
                  defaultPadding * 0.5,
                ),
                child: SearchField(
                  onSearch: (query) {
                    _searchText.value = query;
                  },
                ),
              ),
              Flexible(
                child: FutureBuilder<List<DonationCa>?>(
                    future: Donation_Ca_service.donationUser(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        print(snapshot.hasError.toString());
                        return SizedBox(
                          height: MediaQuery.of(context).size.width * 3,
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return buildMovieShimmer();
                              }),
                        );
                      }
                      if (snapshot.hasData) {
                        List<DonationCa> donationCa =
                            snapshot.data as List<DonationCa>;
                        return ValueListenableBuilder<String?>(
                            valueListenable: _searchText,
                            builder: (context, searchString, _) {
                              var filteredList = donationCa;
                              if (searchString != null &&
                                  searchString.isNotEmpty) {
                                filteredList = donationCa.where(
                                  (element) {
                                    return context.locale == const Locale('ar')
                                        ? element.name_donation_camp!
                                            .toLowerCase()
                                            .contains(
                                                searchString.toLowerCase())
                                        : element.name_donation_camp_en!
                                                .toLowerCase()
                                                .contains(
                                                    searchString
                                                        .toLowerCase()) ||
                                            element.num_of_needy_persons
                                                .toString()
                                                .contains(searchString) ||
                                            element.payment_required
                                                .toString()
                                                .contains(searchString) ||
                                            element.type_camp
                                                .toString()
                                                .contains(searchString);
                                  },
                                ).toList();
                              }
                              return ListView.builder(
                                padding: const EdgeInsets.only(
                                  bottom: defaultPadding * 0.5,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: filteredList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Campigin_don(
                                      campiganID: filteredList[index]
                                          .campiganID,
                                      name_donation_camp:
                                          context.locale == const Locale('ar')
                                              ? filteredList[index]
                                                  .name_donation_camp
                                                  .toString()
                                              : filteredList[index]
                                                  .name_donation_camp_en
                                                  .toString(),
                                      imageUrl: filteredList[index]
                                          .image_url
                                          .toString(),
                                      payment_required: Helpers.getMoneyAmount(
                                          filteredList[index]
                                              .payment_required!),
                                      num_of_needy_person: filteredList[index]
                                          .num_of_needy_persons,
                                      type_camp: context.locale == const Locale('ar')
                                          ? typesOfCampaigns
                                              .where((element) =>
                                                  element.typeId ==
                                                  filteredList[index].type_camp)
                                              .first
                                              .typeNameAr
                                          : typesOfCampaigns
                                              .where((element) =>
                                                  element.typeId ==
                                                  filteredList[index].type_camp)
                                              .first
                                              .typeNameEn,
                                      rememper_cost: Helpers.getMoneyAmount(
                                          filteredList[index].current_amount!));
                                },
                              );
                            });
                      }

                      return Container();
                    }),
              )
            ],
          );
        },
      ),
      //bottomNavigationBar: const BottomsNavigationBar(),
    );
  }
}
