import 'package:charity_management_system/data/model/day_volunteer.dart';
import 'package:charity_management_system/data/model/volunter_model.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/my_activities.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/volunteer_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/helpers.dart';
import '../../../configs/size.dart';
import '../../../configs/theme.dart';

class DetailsVolunter extends StatelessWidget {
  const DetailsVolunter({
    Key? key,
    this.isSubmitHidden,
    required this.volunteerModel,
  }) : super(key: key);
  final VolunteerModel volunteerModel;
  final bool? isSubmitHidden;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 20,
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Theme.of(context).dividerColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          tr('Activity details'),
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 2,
          vertical: defaultPadding,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          '$baseUrl${volunteerModel.image_url}',
                        ),
                        fit: BoxFit.cover),
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('Activity type'),
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 9.sp,
                      ),
                    ),
                    Text(
                      context.locale == const Locale('ar')
                          ? volunteerModel.volunteerSpeciality!.titleAr!
                          : volunteerModel.volunteerSpeciality!.titleEn!,
                      style: TextStyle(
                        //color: Theme.of(context).primaryColor,
                        fontSize: 10.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      context.locale == const Locale('ar')
                          ? volunteerModel.name_vol_cam
                          : volunteerModel.name_vol_cam_en,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: Theme.of(context).progressIndicatorTheme.color,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('Number of volunteers required'),
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(volunteerModel.num_of_vol.toString(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.textDark,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('Current number of volunteers'),
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      volunteerModel.currentNumberOfVolunteers!.toString(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5, vertical: defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('Activity times'),
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr('Duration of activity (number of days)'),
                        style: TextStyle(
                          fontSize: 10.sp,
                        )),
                    Text(volunteerModel.activity_duration.toString(),
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 10.sp,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr('Duration of activity (number of days)'),
                        style: TextStyle(
                          fontSize: 10.sp,
                        )),
                    Text(volunteerModel.startTimeDate.toString(),
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 10.sp,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tr('Duration of activity (number of days)'),
                        style: TextStyle(
                          fontSize: 10.sp,
                        )),
                    Text(volunteerModel.endTimeDate.toString(),
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 10.sp,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                child: Text(
                  tr('Activity days'),
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: volunteerModel.activityDays!
                    .map<Widget>(
                      (e) => SizedBox(width: 150, child: DayItem(day: e)),
                    )
                    .toList(),
              ),
              if (isSubmitHidden == null ||
                  (isSubmitHidden != null && !isSubmitHidden!)) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                    vertical: defaultPadding / 2,
                  ),
                  child: Container(
                    height: 60,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).iconTheme.color,
                        border: Border.all()),
                    child: MaterialButton(
                      onPressed: () {
                        if (volunteerModel.isMeIncluded!) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyActivitiesScreen()));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VolunteerInfoScreen(
                                campaignID: volunteerModel.id,
                              ),
                            ),
                          );
                        }
                      },
                      height: 20,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding / 1.5,
                            horizontal: defaultPadding * 4),
                        child: Text(
                          volunteerModel.isMeIncluded!
                              ? tr('go_to_my_activities')
                              : tr('volunteer now'),
                          style: TextStyle(
                              fontSize: 9.sp,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class DayItem extends StatelessWidget {
  const DayItem({
    Key? key,
    required this.day,
  }) : super(key: key);
  final Day day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 0.5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).iconTheme.color,
        ),
        child: Center(
          child: Text(
            context.locale == const Locale('ar') ? day.nameAr : day.nameEn,
            style: TextStyle(
                fontSize: 8.sp, color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
