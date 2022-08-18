// ignore_for_file: camel_case_types, must_be_immutable, avoid_print
import 'package:charity_management_system/data/model/volunter_model.dart';
import 'package:charity_management_system/view/screens/volunter_campign_screen/details_volunter.dart';
import 'package:charity_management_system/view/widgets/shareButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/helpers.dart';
import '../../../configs/size.dart';

class Campigin_vol extends StatefulWidget {
  const Campigin_vol({
    Key? key,
    required this.volunterIDCampigin,
    required this.volunterNameCampigin,
    required this.volunterNumberNow,
    required this.volunterNumberAll,
    // required this.volunterCreatedAt,
    required this.volunterImageUrlCampigin,
    required this.volunterTypeActive,
    required this.volunteerModel,
    this.isSubmitHidden = false,
  }) : super(key: key);

  final bool? isSubmitHidden;

  final int volunterIDCampigin;
  final String volunterImageUrlCampigin;
  final String volunterNameCampigin;
  final String volunterNumberNow;
  final String volunterNumberAll;
  final String volunterTypeActive;
  final VolunteerModel volunteerModel;

  @override
  State<Campigin_vol> createState() => _Campigin_volState();
}

class _Campigin_volState extends State<Campigin_vol> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsVolunter(
                volunteerModel: widget.volunteerModel,
                isSubmitHidden: widget.isSubmitHidden,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                height: size / 3.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          '$baseUrl${widget.volunterImageUrlCampigin}',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
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
                          tr('Activity type'),
                          style: TextStyle(
                              fontSize: 7.sp, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          widget.volunterTypeActive.toString(),
                          style: const TextStyle(
                              //  color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
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
                          widget.volunterNameCampigin,
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.bold),
                        ),
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
                          tr('Number of volunteers required'),
                          style: TextStyle(
                            // color: AppColors.textDark,
                            fontSize: 9.sp,
                          ),
                        ),
                        Text(widget.volunterNumberAll,
                            style: TextStyle(
                              fontSize: 9.sp,
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
                        Text(tr('Current number of volunteers'),
                            style: TextStyle(
                              //   color: AppColors.textDark,
                              fontSize: 9.sp,
                            )),
                        Text(widget.volunterNumberNow,
                            style: TextStyle(
                              //  color: AppColors.textDark,
                              fontSize: 9.sp,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: MaterialButton(
                          onPressed: () {
                            print('this volunteer model iii' +
                                widget.volunteerModel.toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsVolunter(
                                  volunteerModel: widget.volunteerModel,
                                  isSubmitHidden: widget.isSubmitHidden,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).iconTheme.color),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding / 2,
                                  horizontal: defaultPadding * 1.5),
                              child: Text(
                                tr('More details'),
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: ShareButtonVolunter(
                          widget: widget,
                        ),
                      ),
                    ],
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
