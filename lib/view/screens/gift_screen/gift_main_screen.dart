import 'package:charity_management_system/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:charity_management_system/logic/gifts/gifts_bloc.dart';
import 'package:charity_management_system/view/screens/gift_screen/gift_screen.dart';
import 'package:charity_management_system/view/screens/gift_screen/my_gift_screen.dart';
import 'package:charity_management_system/view/screens/profile_screen/profile/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';

import '../../../../../configs/size.dart';
import '../../../../../translation/locale_keys.g.dart';

class MainMenuGift extends StatelessWidget {
  const MainMenuGift({Key? key}) : super(key: key);

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
          LocaleKeys.gift.tr(),
          style: TextStyle(
            color: Theme.of(context).dividerColor,
            fontSize: 12.sp,
          ),
        ),
      ),
      body: BlocListener<GiftsBloc, GiftsState>(
        listener: (context, state) {
          if (state is GiftSendingFailure) {
            ToastContext().init(context);
            Toast.show(tr('error_while_sending_gift'));
          }
          if (state is GiftAdded) {
            ToastContext().init(context);
            Toast.show(tr('gift_sent_successfully'));
          }
        },
        child: Column(
          children: [
            ProfileCard(
              icon: Icons.card_giftcard,
              title: LocaleKeys.start_the_gift.tr(),
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GiftScreen()),
                );
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is! AuthUnauthenticated) {
                  return ProfileCard(
                    icon: Icons.tips_and_updates,
                    title: LocaleKeys.my_gifts.tr(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyGiftScreen(),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      ),
    );
  }
}
