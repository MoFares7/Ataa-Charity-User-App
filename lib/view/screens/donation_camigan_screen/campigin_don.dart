// ignore_for_file: must_be_immutable, prefer_const_constructors, camel_case_types, non_constant_identifier_names

import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/data/model/dialog_provider.dart';
import 'package:charity_management_system/view/screens/payment_donation_screen/normal_donation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/size.dart';
import '../../../translation/locale_keys.g.dart';
import '../../widgets/donation_button.dart';
import '../../widgets/shareButton.dart';

class Campigin_don extends StatefulWidget with DialogProvider {
  const Campigin_don({
    Key? key,
    required this.campiganID,
    required this.name_donation_camp,
    required this.imageUrl,
    required this.payment_required,
    required this.num_of_needy_person,
    required this.type_camp,
    required this.rememper_cost,
  }) : super(key: key);

  final int? campiganID;
  final String name_donation_camp;
  final String imageUrl;
  final String payment_required;
  final int? num_of_needy_person;
  final String type_camp;
  final String rememper_cost;

  @override
  State<Campigin_don> createState() => _Campigin_donState();
}

class _Campigin_donState extends State<Campigin_don> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          //height: size.height / 1.8,
          //  width: size.width / 1.1,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                height: size.height / 3.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      '$baseUrl${widget.imageUrl}',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.num_of_needy_person.toString()} ${tr('needy')}",
                          style: TextStyle(
                            fontSize: 7.sp,
                          ),
                        ),
                        SizedBox(
                          width: defaultPadding,
                        ),
                        Container(
                            width: 19.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                                color: Theme.of(context).iconTheme.color,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                widget.type_camp.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 8.sp),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name_donation_camp,
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(widget.payment_required,
                            style: TextStyle(
                              fontSize: 8.sp,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.remember_cost.tr(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 9.sp,
                            )),
                        Text(widget.rememper_cost,
                            style: TextStyle(
                              fontSize: 8.sp,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DonationButton(
                          textcolor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            await NormalDonationScreen(
                                context: context,
                                campaignID: widget.campiganID!,
                                onPayPressed: (paidAmount) async {
                                  if (kDebugMode) {
                                    print('paidAmount: $paidAmount');
                                  }
                                });
                          },
                        ),
                        ShareButton(
                          widget: widget,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              )
            ],
          ),
        ),
      ),
    );
  }
}
