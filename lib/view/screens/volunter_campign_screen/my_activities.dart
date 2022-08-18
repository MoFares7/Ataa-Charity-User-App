import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/data/content/volunteer_services.dart';
import 'package:charity_management_system/data/model/volunter_model.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/campigin_vol.dart';
import 'package:charity_management_system/view/widgets/no_data_widget.dart';
import 'package:charity_management_system/view/widgets/un_exptected_error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyActivitiesScreen extends StatelessWidget {
  MyActivitiesScreen({Key? key}) : super(key: key);

  final ValueNotifier<bool> isRefreshing = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          tr('my_activities'),
          style: TextStyle(
            fontSize: 12.sp,
            color: Theme.of(context).dividerColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isRefreshing,
        builder: (context, refresh, _) {
          return FutureBuilder<List<VolunteerModel>?>(
            future: VolunterServices.getVolunterService(),
            builder: (context, snapshot) {
              //! if has error in fetch data will show widget Error and refresh
              if (snapshot.hasError) {
                return UnExpectedErrorWidget(
                  onRetry: () {
                    isRefreshing.value = !refresh;
                  },
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //! if no error but no Data
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return NoDataWidget(
                    title: tr('my_activities_empty'),
                    onRetry: () {
                      isRefreshing.value = !refresh;
                    },
                  );
                }

                final List<VolunteerModel> volunteerModels = snapshot.data!;
                final myActivities = volunteerModels
                    .where((volunteerModel) => volunteerModel.isMeIncluded!)
                    .toList();
                return RefreshIndicator(
                  onRefresh: () async {
                    isRefreshing.value = !refresh;
                  },
                  color: Theme.of(context).dividerColor,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: myActivities.length,
                    itemBuilder: (context, index) {
                      return Campigin_vol(
                        volunterIDCampigin: myActivities[index].id,
                        volunterImageUrlCampigin: myActivities[index].image_url,
                        volunterNameCampigin:
                            context.locale == const Locale('ar')
                                ? myActivities[index].name_vol_cam
                                : myActivities[index].name_vol_cam_en,
                        volunterNumberAll:
                            myActivities[index].num_of_vol.toString(),
                        volunterNumberNow: myActivities[index]
                            .currentNumberOfVolunteers!
                            .toString(),
                        volunterTypeActive: context.locale == const Locale('ar')
                            ? myActivities[index].volunteerSpeciality!.titleAr!
                            : myActivities[index].volunteerSpeciality!.titleEn!,
                        volunteerModel: myActivities[index],
                        isSubmitHidden: true,
                      );
                    },
                    separatorBuilder: (ctx, _) => const SizedBox(
                      height: defaultPadding * 0.5,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
