// ignore_for_file: non_constant_identifier_names
import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/data/content/person_of_needy.dart';
import 'package:charity_management_system/data/model/get_gift.dart';
import 'package:charity_management_system/logic/gifts/gifts_bloc.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:charity_management_system/view/widgets/main_buttom.dart';
import 'package:charity_management_system/view/widgets/phone_number_form.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/helpers.dart';
import '../../../data/model/person.dart';
import 'payment_way_screen.dart';

class GiftScreen extends StatefulWidget {
  const GiftScreen({Key? key}) : super(key: key);

  static const String routeName = 'Gift_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const GiftScreen(),
    );
  }

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  @override
  void initState() {
    super.initState();
    //TODO check that
    PersonServices.getPersonService();
  }

  final _formKey = GlobalKey<FormState>();
  late List<Person> persons = [];

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
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: Center(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 2),
                    child: Text(
                      tr('Ataa gift'),
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.7)),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2),
                    child: Center(
                      child: Text(
                        tr('descrip gift'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Theme.of(context)
                                .dividerColor
                                .withOpacity(0.8)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Center(
                      child: Lottie.asset(
                    'assets/gift.json',
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                  )),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 5),
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).iconTheme.color,
                          border: Border.all()),
                      child: MaterialButton(
                        onPressed: () async {
                          await GitButtomSheet(
                            context: context,
                          );
                        },
                        height: 20,
                        minWidth: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding / 1.4),
                          child: Text(
                            tr('send gift'),
                            style: TextStyle(
                                fontSize: 9.sp,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  )
                ])),
      ),
    );
  }

  Future<dynamic> GitButtomSheet({
    required BuildContext context,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom / 3,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('gift donation'),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 2),
                        child: Text(
                          tr('Gift sender name'),
                          style: TextStyle(
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      TextFormGift(
                          hintText: tr('Gift sender name'),
                          controller: senderGift,
                          inputType: TextInputType.name,
                          validator: (content) {
                            if (content == null || content.isEmpty) {
                              return tr('The field is required');
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 2),
                        child: Text(
                          tr('Gift sender number'),
                          style: TextStyle(
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      PhoneFormEditing(
                        hintText: '+963xxxxxxxx  ',
                        controller: phoneNumberSender,
                        inputType: TextInputType.phone,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: tr('The field is required')),
                          EmailValidator(errorText: '  ادخل  الصحيح')
                        ]),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 2),
                        child: Text(
                          tr('Gift recipient name'),
                          style: TextStyle(
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      FutureBuilder(
                        future: PersonServices.getPersonService(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<List<Person>?> snapshot,
                        ) {
                          return TextFormGift(
                            hintText: tr('Gift recipient name'),
                            controller: reciverGift,
                            inputType: TextInputType.name,
                            validator: (content) {
                              if (content == null || content.isEmpty) {
                                return tr('The field is required');
                              }
                              if (snapshot.data != null) {
                                if (snapshot.data!
                                    .where((element) =>
                                        element.fullname.contains(content))
                                    .toList()
                                    .isEmpty) {
                                  return tr(
                                      'The person does not belong to the ataa charity');
                                }
                                persons = snapshot.data!;
                              } else {
                                return tr('Please enter the name again');
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      MainButtom(
                        title: tr('Completing the gifting process'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            GiftPaymentOperation(
                              context: context,
                              onPayPressed: (giftPaidAmount) async {
                                if (kDebugMode) {
                                  print('giftPaidAmount: $giftPaidAmount');
                                }

                                final person_id = persons
                                    .where((element) => element.fullname
                                        .contains(reciverGift.text.trim()))
                                    .first
                                    .id;

                                // Get User ID from shared Preferences
                                final currentUserId = await loadUserID();

                                if (currentUserId == -1) {
                                  showNotLoggedInDialog(context);
                                  /**
                                  * ToastContext().init(context);
                                  Toast.show(
                                    tr('make_sure_to_sign_in_first'),
                                    duration: Toast.lengthLong,
                                    gravity: Toast.bottom,
                                  );
                                   */
                                } else {
                                  context.read<GiftsBloc>().add(SendGift(
                                      giftModel: GiftModel(
                                          senderID: currentUserId,
                                          personID: person_id,
                                          senderName: senderGifts,
                                          senderPhone: phoneSenderGift,
                                          giftValue: double.parse(
                                            giftPaidAmount,
                                          ))));
                                  int count = 0;
                                  Navigator.of(context)
                                      .popUntil((_) => count++ >= 2);
                                }
                              },
                            );
                          
                            
                          } else {
                            reciverGift.clear();
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void pageRoute(int id, String fullName) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString("f_name", fullName);
  await pref.setInt("id", id);
}

class TextFormGift extends StatelessWidget {
  const TextFormGift({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.inputType,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 2,
      ),
      child: Center(
        child: TextFormField(
          // maxLength: 10,

          validator: validator,
          controller: controller,
          keyboardType: inputType,
          autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(
            // filled: true,
            //  fillColor: AppColors.scaffoldColor,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey, // <-- Change this
              fontSize: 8.sp,
              fontWeight: FontWeight.w400,
              // fontStyle: FontStyle.normal,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.primary1),
            ),
          ),
        ),
      ),
    );
  }
}
