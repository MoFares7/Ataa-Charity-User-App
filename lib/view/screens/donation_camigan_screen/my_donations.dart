import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/data/content/donation_service.dart';
import 'package:charity_management_system/data/model/add_donation_oper.dart';
import 'package:charity_management_system/view/widgets/data_card.dart';
import 'package:charity_management_system/view/widgets/info_row.dart';
import 'package:charity_management_system/view/widgets/no_data_widget.dart';
import 'package:charity_management_system/view/widgets/un_exptected_error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyDonationsScreen extends StatelessWidget {
  MyDonationsScreen({
    Key? key,
    required this.userID,
  }) : super(key: key);

  final ValueNotifier<bool> refresh = ValueNotifier(false);
  final int userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          tr('My Donation'),
          style: TextStyle(fontSize: 12.sp),
        ),
        centerTitle: true,
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
      ),
      body: ValueListenableBuilder<bool>(
          valueListenable: refresh,
          builder: (context, isRefreshing, _) {
            return FutureBuilder<List<AddDonationOperation>?>(
              future: Donation_Ca_service.getMyPreviousDonationOperations(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return UnExpectedErrorWidget(
                    onRetry: () {
                      refresh.value = !isRefreshing;
                    },
                  );
                }
                if (snapshot.hasData) {
                  final List<AddDonationOperation> operations = snapshot.data!;
                  final myDonations = operations
                      .where((element) => element.user_id == userID)
                      .toList();
                  if (myDonations.isEmpty) {
                    return NoDataWidget(
                      title: tr('no donations'),
                      onRetry: () {
                        refresh.value = !isRefreshing;
                      },
                    );
                  }
                  return ListView.builder(
                    itemCount: myDonations.length,
                    itemBuilder: (context, index) {
                      return DonationOperationCard(
                        donationOperation: myDonations[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }),
    );
  }
}

class DonationOperationCard extends StatelessWidget {
  const DonationOperationCard({
    Key? key,
    required this.donationOperation,
  }) : super(key: key);

  final AddDonationOperation donationOperation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: DataCard(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(
              width: 1.5,
              color: AppColors.primary1,
            ),
            child: InformationRow(
              title: tr('donation_id'),
              value: donationOperation.id.toString(),
              titleColor: AppColors.primary1,
              valueColor: AppColors.primary1,
            ),
          ),
        ),
        DataCard(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InformationRow(
                  title: tr('name of the donation campaign'),
                  value: context.locale == const Locale('ar')
                      ? donationOperation.donationCampaign!.name_donation_camp
                      : donationOperation
                          .donationCampaign!.name_donation_camp_en,
                ),
                const SizedBox(height: defaultPadding * 0.25),
                InformationRow(
                  title: tr('Donated Amount'),
                  value: donationOperation.amount_paid,
                ),
                const SizedBox(height: defaultPadding * 0.25),
                InformationRow(
                  title: tr('Donation date'),
                  value: DateFormat('yyyy/MM/dd').format(
                    donationOperation.paymentDate!,
                  ),
                ),
                const SizedBox(height: defaultPadding * 0.25),
                InformationRow(
                  title: tr('Donation status'),
                  value: tr('${donationOperation.donationCampaign!.status}'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
