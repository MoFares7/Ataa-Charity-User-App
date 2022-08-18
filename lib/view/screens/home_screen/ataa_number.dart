// ignore_for_file: non_constant_identifier_names
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/size.dart';

class AtaaNumbers extends StatelessWidget {
  const AtaaNumbers({
    Key? key,
    required this.size,
    required this.totalDonation,
    required this.tottalNumberOfVolunteer,
    required this.countOfCharityActivities,
    required this.numberOfPersonWithSpecialNeeds,
  }) : super(key: key);

  final Size size;
  final double? totalDonation;
  final int? tottalNumberOfVolunteer;
  final int? countOfCharityActivities;
  final int? numberOfPersonWithSpecialNeeds;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height / 1.7,
      width: size.width / 1.2,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromARGB(197, 255, 255, 255),
              Color.fromARGB(181, 155, 155, 155)
            ],
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        const SizedBox(
          height: defaultPadding,
        ),
        Text(
          LocaleKeys.atta_number.tr(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Container(
          // height: size.height / 7,
          width: size.width / 1.7,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //   SvgPicture.asset("assets/icons/money.assets"),
              Text(
                LocaleKeys.total_donations.tr(),
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
              Text(
                totalDonation.toString(),
                style: TextStyle(
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //height: size.height / 7,
              width: size.width / 2.7,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.number_of_shareholders.tr(),
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    tottalNumberOfVolunteer.toString(),
                    style: TextStyle(
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: defaultPadding,
            ),
            Container(
              //     height: size.height / 7,
              width: size.width / 2.7,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      LocaleKeys.the_number_of_beneficiaries.tr(),
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  Text(
                    numberOfPersonWithSpecialNeeds.toString(),
                    style: TextStyle(
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Container(
          //   height: size.height / 7,
          width: size.width / 1.7,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.the_number_of_activities_of_the_association.tr(),
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
              Text(
                countOfCharityActivities.toString(),
                style: TextStyle(
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: defaultPadding * 2,
        )
      ]),
    );
  }
}
