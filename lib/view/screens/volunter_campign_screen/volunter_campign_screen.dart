// ignore_for_file: avoid_print, non_constant_identifier_names, avoid_unnecessary_containers
import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/data/content/volunteer_services.dart';
import 'package:charity_management_system/data/model/volunter_model.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/campigin_vol.dart';
import 'package:charity_management_system/view/widgets/search_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/shimmer.dart';

class VolunterCampignScreen extends StatefulWidget {
  const VolunterCampignScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VolunterCampignScreen> createState() => _VolunterCampignScreenState();
}

class _VolunterCampignScreenState extends State<VolunterCampignScreen> {

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
            tr('Volunteer Campaigns'),
            style: TextStyle(
                color: Theme.of(context).dividerColor, fontSize: 12.sp),
          ),
        ),
        body: ValueListenableBuilder<bool>(
            valueListenable: refresh,
            builder: (context, isRefresh, _) {
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
                    child: FutureBuilder<List<VolunteerModel>?>(
                      future: VolunterServices.getVolunterService(),
                      builder: (context, snapshot) {
                        //? if no data will run this sections
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
                          List<VolunteerModel> getVolunteer =
                              snapshot.data as List<VolunteerModel>;
                          return ValueListenableBuilder<String?>(
                            valueListenable: _searchText,
                            builder: (context, searchString, _) {
                              var filteredList = getVolunteer;
                              if (searchString != null &&
                                  searchString.isNotEmpty) {
                                filteredList = getVolunteer.where(
                                  (element) {
                                    //! Search on volunteer Campigins about all Atributs
                                    return context.locale == const Locale('ar')
                                        ? element.name_vol_cam
                                            .toLowerCase()
                                            .contains(
                                                searchString.toLowerCase())
                                        : element.name_vol_cam_en
                                                .toLowerCase()
                                                .contains(searchString
                                                    .toLowerCase()) ||
                                            element.num_of_vol
                                                .toString()
                                                .contains(searchString) ||
                                            element.activityDays
                                                .toString()
                                                .contains(searchString) ||
                                            element.startDate
                                                .toString()
                                                .contains(searchString) ||
                                            element.endDate
                                                .toString()
                                                .contains(searchString) ||
                                            element.endTimeDate
                                                .toString()
                                                .contains(searchString) ||
                                            element.activity_duration
                                                .toString()
                                                .contains(searchString);
                                  },
                                ).toList();
                              }
                              //! Send request to add Volunteer after fill all Data required
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: filteredList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Campigin_vol(
                                    volunterIDCampigin: filteredList[index].id,
                                    volunterNameCampigin: context.locale ==
                                            const Locale('ar')
                                        ? filteredList[index]
                                            .name_vol_cam
                                            .toString()
                                        : filteredList[index].name_vol_cam_en,
                                    volunterImageUrlCampigin:
                                        filteredList[index]
                                            .image_url
                                            .toString(),
                                    volunterNumberAll: filteredList[index]
                                        .num_of_vol
                                        .toString(),
                                    // volunterCreatedAt: filteredList[index].startDate,
                                    volunterTypeActive:
                                        context.locale == const Locale('ar')
                                            ? filteredList[index]
                                                .volunteerSpeciality!
                                                .titleAr!
                                            : filteredList[index]
                                                .volunteerSpeciality!
                                                .titleEn!,
                                    volunterNumberNow: filteredList[index]
                                        .currentNumberOfVolunteers!
                                        .toString(),
                                    volunteerModel: filteredList[index],
                                  );
                                },
                              );
                            },
                          );
                        }

                        return Container();
                      },
                    ),
                  )
                ],
              );
            })
        //bottomNavigationBar: const BottomsNavigationBar(),
        );
  }
}
