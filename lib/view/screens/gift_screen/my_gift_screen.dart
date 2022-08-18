// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print
import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/data/model/get_gift.dart';
import 'package:charity_management_system/logic/gifts/gifts_bloc.dart';
import 'package:charity_management_system/view/widgets/data_card.dart';
import 'package:charity_management_system/view/widgets/info_row.dart';
import 'package:charity_management_system/view/widgets/no_data_widget.dart';
import 'package:charity_management_system/view/widgets/un_exptected_error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MyGiftScreen extends StatefulWidget {
  const MyGiftScreen({Key? key}) : super(key: key);

  @override
  State<MyGiftScreen> createState() => _MyGiftScreenState();
}

class _MyGiftScreenState extends State<MyGiftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        title: Text(
          tr('my gifts'),
          style: TextStyle(
            color: Theme.of(context).dividerColor,
            fontSize: 12.sp,
          ),
        ),
      ),
      body: RefreshIndicator(
        color: Theme.of(context).dividerColor,
        onRefresh: () async {
          context.read<GiftsBloc>().add(GetGifts());
        },
        child: BlocBuilder<GiftsBloc, GiftsState>(
          builder: (context, state) {
            if (state is GiftsLoading || state is GiftAdded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GiftsLoadFailure) {
              return UnExpectedErrorWidget(
                onRetry: () {
                  context.read<GiftsBloc>().add(GetGifts());
                },
              );
            }
            if (state is GiftsLoaded) {
              if (state.gifts.isEmpty) {
                return NoDataWidget(
                  title: tr('no_gifts_to_show_up'),
                  onRetry: () {
                    context.read<GiftsBloc>().add(GetGifts());
                  },
                );
              }

              List<GiftModel> gifts = state.gifts;
              return ListView.separated(
                padding: const EdgeInsets.all(defaultPadding),
                itemCount: gifts.length,
                separatorBuilder: (ctx, _) =>
                    const SizedBox(height: defaultPadding * 0.5),
                itemBuilder: (BuildContext context, int index) {
                  print('gift($index): ${gifts[index].toString()}');
                  return GiftCard(
                    giftModel: gifts[index],
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class GiftCard extends StatelessWidget {
  const GiftCard({
    Key? key,
    required this.giftModel,
  }) : super(key: key);
  final GiftModel giftModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DataCard(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          border: Border.all(
            width: 1.5,
            color: AppColors.primary1,
          ),
          child: InformationRow(
            title: tr('gift_id'),
            value: giftModel.id.toString(),
            titleColor: AppColors.primary1,
            valueColor: AppColors.primary1,
          ),
        ),
        DataCard(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InformationRow(
                title: tr('sender_name'),
                value: giftModel.senderName,
              ),
              const SizedBox(height: defaultPadding * 0.25),
              InformationRow(
                title: tr('reciepent_name'),
                value: giftModel.recipientName,
              ),
              const SizedBox(height: defaultPadding * 0.25),
              InformationRow(
                title: tr('gift_value'),
                value: Helpers.getMoneyAmount(giftModel.giftValue!),
              ),
              const SizedBox(height: defaultPadding * 0.25),
              InformationRow(
                title: tr('gift_status'),
                value: tr(
                    giftModel.isDelivered! ? 'delivered' : 'awaiting_delivery'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
