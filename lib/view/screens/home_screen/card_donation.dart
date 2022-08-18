// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/data/content/donation_service.dart';
import 'package:charity_management_system/data/model/dialog_provider.dart';
import 'package:charity_management_system/view/screens/donation_camigan_screen/campigin_don.dart';
import 'package:charity_management_system/view/screens/payment_donation_screen/normal_donation.dart';
import 'package:charity_management_system/view/widgets/donation_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/helpers.dart';
import '../../widgets/shareButton.dart';

class CardsDonaition extends StatelessWidget with DialogProvider {
  const CardsDonaition({
    Key? key,
    required this.campiganID,
    required this.image_url,
    required this.type_camp,
    required this.name_donation_camp,
    required this.payment_required,
    required this.remember,
    required this.num_of_needy_person,
  }) : super(key: key);

  final int? campiganID;
  final String image_url;
  final String type_camp;
  final String name_donation_camp;
  final String payment_required;
  final String remember;
  final int? num_of_needy_person;

  get widget => Campigin_don(
        campiganID: campiganID,
        name_donation_camp: name_donation_camp,
        imageUrl: image_url,
        payment_required: payment_required,
        num_of_needy_person: num_of_needy_person,
        type_camp: type_camp,
        rememper_cost: remember,
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Donation_Ca_service? donation_ca_service;
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: size.width / 1.4,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              height: size.height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        '$baseUrl${widget.imageUrl}',
                      ),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
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
                        "${num_of_needy_person.toString()} ${tr('needy')} ",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 8, 101, 68),
                            fontSize: 8.sp),
                      ),
                      Container(
                          width: 17.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                              color: Theme.of(context).iconTheme.color,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              type_camp.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12),
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
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 3),
                          child: Text(
                            name_donation_camp,
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color,
                                fontSize: 9.sp,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(
                        payment_required,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 7.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tr('Remaining amount'),
                          style: TextStyle(
                            // color: AppColors.textDark,
                            fontSize: 8.sp,
                          )),
                      Text(remember,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            // color: AppColors.textDark,
                            fontSize: 7.sp,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DonationButton(
                      textcolor: Theme.of(context).primaryColor,
                      onPressed: () async {
                        await NormalDonationScreen(
                          context: context,
                          campaignID: campiganID!,
                          onPayPressed: (paidAmount) async {
                            if (kDebugMode) {
                              print('paidAmount: $paidAmount');
                            }

                            // Get user id from shared preferences
                            // final prefs =
                            // await SharedPreferences.getInstance();
                            //
                            // final userID = prefs.getInt('user_id');
                            // var campaignId = campiganID;
                            // const paymentMethodID = '2';
                            //
                            // print(
                            //     'DonationOperation Object : ${AddDonationOperation(
                            //       user_id: userID!,
                            //       donation_campaign_id: campaignId,
                            //       payment_method_id: paymentMethodID,
                            //       amount_paid: paidAmount,
                            //     ).toJson()}');
                            // var succeed = await Donation_Ca_service
                            //     .addDonationOperation(
                            //   AddDonationOperation(
                            //     user_id: userID!,
                            //     donation_campaign_id: campaignId,
                            //     payment_method_id: paymentMethodID,
                            //     amount_paid: paidAmount,
                            //   ),
                            // );
                            //
                            // if (kDebugMode) {
                            //   print('succeed: ');
                            // }
                            //
                            // if (succeed!) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text('Thanks for Donation'),
                            //     ),
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text('Error Occurred'),
                            //     ),
                            //   );
                            // }
                          },
                        );
                      },
                    ),
                    ShareButton(widget: widget),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
