// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:io';

import 'package:charity_management_system/data/content/volunteer_services.dart';
import 'package:charity_management_system/data/model/add_vlounteer.dart';
import 'package:charity_management_system/data/model/dialog_provider.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:charity_management_system/view/widgets/main_buttom.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/helpers.dart';
import '../../../configs/size.dart';
import '../../../logic/bloc/auth/auth_bloc_bloc.dart';
import '../login_screen/login_screen.dart';

class VolunteerInfoScreen extends StatefulWidget {
  const VolunteerInfoScreen({
    Key? key,
    required this.campaignID,
  }) : super(key: key);
  final int campaignID;

  @override
  State<VolunteerInfoScreen> createState() => _VolunteerInfoScreenState();
}

class _VolunteerInfoScreenState extends State<VolunteerInfoScreen>
    with DialogProvider {
  final TextEditingController _email_Vol_Controller = TextEditingController();
  final TextEditingController _first_Name_Vol_Controller =
      TextEditingController();
  final TextEditingController _last_Name_Vol_Controller =
      TextEditingController();
  final TextEditingController _phone_Number_Vol_Controller =
      TextEditingController();
  final TextEditingController _univarsity_Vol_controller =
      TextEditingController();
  final TextEditingController _experince_Vol_Controller =
      TextEditingController();
  final ValueNotifier<File?> certificateFileNotifier =
      ValueNotifier<File?>(null);

  final formKey = GlobalKey<FormState>();

  String date = "";

  DateTime nowDate = DateTime(2012, 1, 1);

  DateTime now = DateTime.now();

  Future<DateTime?> selectDateDialog(
    BuildContext context, [
    DateTime? initialDate,
  ]) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary:
                    Theme.of(context).hoverColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Theme.of(context)
                    .hoverColor
                    .withOpacity(0.5), // body text color
              ),
            ),
            child: child!,
          );
        },
        initialDate: initialDate ?? DateTime(2000),
        firstDate: DateTime(1940),
        // subtract 3 years from current year to prevent user from selecting near date
        lastDate: DateTime.now().subtract(const Duration(days: 365 * 3)));
    if (picked != null) {
      setState(() {
        nowDate = picked;
      });
    }
    return initialDate;
  }

  @override
  Widget build(BuildContext context) {
    checkInternet() async {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        check(context);
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
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
            tr('volunteer'),
            style: TextStyle(
                color: Theme.of(context).dividerColor, fontSize: 12.sp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formKey,
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        tr('Volunteer information'),
                        style: TextStyle(
                          fontSize: 11.sp,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextFormVolunteer(
                      hintText: LocaleKeys.first_name.tr(),
                      controller: _first_Name_Vol_Controller,
                      inputType: TextInputType.name,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: tr('The field is required')),
                        EmailValidator(errorText: 'Enter Valid First Name')
                      ]),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    TextFormVolunteer(
                      hintText: LocaleKeys.last_name.tr(),
                      controller: _last_Name_Vol_Controller,
                      inputType: TextInputType.name,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: tr('The field is required')),
                        EmailValidator(errorText: 'Enter Valid Last Name')
                      ]),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    TextFormVolunteer(
                      hintText: LocaleKeys.phone_number.tr(),
                      controller: _phone_Number_Vol_Controller,
                      inputType: TextInputType.phone,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: tr('The field is required')),
                        EmailValidator(errorText: 'Enter Valid Phone Number')
                      ]),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    TextFormVolunteer(
                      hintText: LocaleKeys.email.tr(),
                      controller: _email_Vol_Controller,
                      inputType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: tr('The field is required')),
                        EmailValidator(errorText: 'Enter Valid Email')
                      ]),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    TextFormVolunteer(
                      hintText: tr('Undergraduate degree'),
                      controller: _univarsity_Vol_controller,
                      inputType: TextInputType.emailAddress,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: tr('The field is required')),
                        EmailValidator(errorText: 'Enter Valid Email')
                      ]),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    TextFormVolunteer(
                      hintText: tr('Years of Experience'),
                      controller: _experince_Vol_Controller,
                      inputType: TextInputType.number,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: tr('The field is required')),
                        MaxLengthValidator(2, errorText: ' can not more 2'),
                        EmailValidator(errorText: 'Enter Valid exp_years'),
                      ]),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                                  '${nowDate.year}/${nowDate.month}/${nowDate.day}')),
                          Expanded(
                            child: Container(
                              height: 5.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).iconTheme.color,
                                  border: Border.all()),
                              child: MaterialButton(
                                onPressed: () async {
                                  selectDateDialog(context);
                                },
                                //    height: 20,
                                //  minWidth: 20,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding / 2),
                                  child: Text(
                                    tr('Date of Birth'),
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tr('Undergraduate degree'),
                              style: TextStyle(
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 5.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).iconTheme.color,
                                  border: Border.all()),
                              child: MaterialButton(
                                onPressed: () async {
                                  final result = await FilePicker.platform
                                      .pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf']);
                                  if (result == null) {
                                    return;
                                  }
                                  // Open Single file
                                  final file = result.files.first;
                                  //   openFile(file);
                                  final File certificateFile = File(file.path!);
                                  certificateFileNotifier.value =
                                      certificateFile;
                                },
                                height: 20,
                                minWidth: 20,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding / 2),
                                  child: Text(
                                    tr('Choose the file'),
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return MainButtom(
                          title: tr('volunteer now'),
                          onPressed: () async {
                            //? Get user id from shared preferences
                            final prefs = await SharedPreferences.getInstance();
                            final userID = prefs.getInt('user_id');
                            var campiginVolunteerID = widget.campaignID;
                            //? First Check connect With internet or not
                            checkInternet();
                            if (state is AuthAuthenticated) {
                              if (formKey.currentState!.validate() &&
                                  certificateFileNotifier.value != null) {
                                VolunterServices.addVolunteerServices(
                                    AddVolunteerModel(
                                  joinDate: now,
                                  univarcity_degree:
                                      _univarsity_Vol_controller.text,
                                  certificateFile:
                                      certificateFileNotifier.value!,
                                  user_id: userID,
                                  f_name: _first_Name_Vol_Controller.text,
                                  l_name: _last_Name_Vol_Controller.text,
                                  brithdate: nowDate,
                                  exp_years: _experince_Vol_Controller.text,
                                  phone_num: _phone_Number_Vol_Controller.text,
                                  email: _email_Vol_Controller.text,
                                  volunteer_campaign_id: campiginVolunteerID,
                                ));
                                Navigator.pop(context);
                                ShowDialogeDone(context);
                                print(' add volunteer is done');
                              }
                            } else {
                              final bool? goToLoginScreen =
                                  await showNotLoggedInDialog(context);

                              if (goToLoginScreen != null && goToLoginScreen) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                  ]),
            ),
          ),
        ));
  }
}

class TextFormVolunteer extends StatelessWidget {
  const TextFormVolunteer({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.inputType,
  }) : super(key: key);

  final String hintText;
  final FieldValidator validator;
  final TextEditingController controller;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return tr('The field is required');
          }
          return null;
        },
        controller: controller,
        keyboardType: inputType,
        autofillHints: const [AutofillHints.email],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey, // <-- Change this
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
            // fontStyle: FontStyle.normal,
          ),
        ),
      ),
    );
  }
}
