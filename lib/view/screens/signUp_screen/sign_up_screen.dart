// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member, unused_element

import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/logic/bloc/registration/registration_bloc_bloc.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:charity_management_system/view/screens/home_screen/root_screen_state.dart';
import 'package:charity_management_system/view/screens/login_screen/login_screen.dart';
import 'package:charity_management_system/view/widgets/email_filed.dart';
import 'package:charity_management_system/view/widgets/password-filed.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/size.dart';
import '../../widgets/main_buttom.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  static const String routeName = 'sign_up_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SignUpScreen(),
    );
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    checkInternet() async {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        check(context);
      }
    }

    _registrationButtonPressed() {
      String first_name = _firstNameController.text.trim();
      String last_name = _lastNameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text;

      // add register event to registration bloc
      context.read<RegistrationBloc>().add(
            RegisterButtonPressed(
              first_name: first_name,
              last_name: last_name,
              email: email,
              password: password,
            ),
          );
    }

    _registerationEmailDubilcated() {
      String first_name = _firstNameController.text.trim();
      String last_name = _lastNameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text;

      context.read<RegistrationBloc>().add(RegisterEmailDublicated(
            first_name: first_name,
            last_name: last_name,
            email: email,
            password: password,
          ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).hoverColor,
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationFaliure) {
            var snackBar = SnackBar(
              content: Text(tr('un_expected_error_occurred')),
              duration: const Duration(milliseconds: 1000),
            );
            // show snackBar to tell user that login has failed
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is RegisterationEmailDublicated) {
            var snackBar = SnackBar(
              content: Text(tr('duplicate email')),
              duration: const Duration(milliseconds: 1000),
            );
            // show snackBar to tell user that login has failed
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is RegistrationInitial) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Stack(children: [
            Image.asset(
              "assets/images/Mask_Group.png",
              fit: BoxFit.fill,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      AspectRatio(
                          aspectRatio: 4 / 1.2,
                          child: Image.asset("assets/images/signup.png")),
                      Text(
                        LocaleKeys.new_logain.tr(),
                        style: TextStyle(fontSize: 10.sp, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 3),
                        child: Center(
                          child: Text(LocaleKeys.subtitle.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 7.sp, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // height: 400,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                      horizontal: defaultPadding * 2),
                                  child: Text(
                                    LocaleKeys.first_name.tr(),
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                ),
                                NameFormEditing(
                                  hintText: LocaleKeys.first_name.tr(),
                                  controller: _firstNameController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                      errorText: tr('The field is required'),
                                    ),
                                    MaxLengthValidator(15,
                                        errorText:
                                            'لا يمكن إدخال أكثر من 15 حرف'),
                                    MinLengthValidator(3,
                                        errorText:
                                            'لا يمكن إدخال أقل من 3 حرف'),
                                    EmailValidator(
                                        errorText: 'ادخل الاسم الصحيح')
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                      horizontal: defaultPadding * 2),
                                  child: Text(
                                    LocaleKeys.last_name.tr(),
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                ),
                                NameFormEditing(
                                  hintText: LocaleKeys.last_name.tr(),
                                  controller: _lastNameController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: tr('The field is required')),
                                    MaxLengthValidator(15,
                                        errorText:
                                            'لا يمكن إدخال أكثر من 15 حرف'),
                                    MinLengthValidator(3,
                                        errorText:
                                            'لا يمكن إدخال أقل من 3 حرف'),
                                    EmailValidator(
                                        errorText: '  ادخل الاسم الصحيح')
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                      horizontal: defaultPadding * 2),
                                  child: Text(
                                    LocaleKeys.email.tr(),
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                ),
                                TextFormEditing(
                                  hintText: "  domain@gmail.com ",
                                  controller: _emailController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: tr('The field is required')),
                                    EmailValidator(
                                        errorText:
                                            'ادخل البريد الالكتروني الصحيح  ')
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                      horizontal: defaultPadding * 2),
                                  child: Text(
                                    LocaleKeys.password.tr(),
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                ),
                                PasswordFormFiled(
                                    hintText: tr('password'),
                                    controller: _passwordController,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              tr('The field is required')),
                                      MaxLengthValidator(15,
                                          errorText:
                                              'لا يمكن إدخال أكثر من 15 محرف'),
                                      MinLengthValidator(7,
                                          errorText:
                                              'لا يمكن إدخال أقل من 7 محرف'),
                                      EmailValidator(
                                          errorText:
                                              '  ادخل  كلمة المرور الصحيح')
                                    ]),
                                    icon: Icons.lock),
                                const SizedBox(
                                  height: defaultPadding * 1.5,
                                ),
                                BlocBuilder<RegistrationBloc,
                                        RegistrationState>(
                                    builder: (context, state) {
                                  if (state is RegistrationLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary1,
                                      ),
                                    );
                                  }
                                  //! Now when user prees button first checkInternet and second validation
                                  return MainButtom(
                                    onPressed: () async {
                                      // checkInternet();
                                      if (formKey.currentState!.validate()) {
                                        //_registerationEmailDubilcated();
                                        _registrationButtonPressed();
                                      }
                                    },
                                    // textcolor: AppColors.textLigth,
                                    title: LocaleKeys.create_account.tr(),
                                  );
                                }),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                MainButtom(
                                  onPressed: () async {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RootScreenState()),
                                    );
                                  },
                                  // textcolor: AppColors.textDark,
                                  title: LocaleKeys.login_as_guest.tr(),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocaleKeys.info_account.tr(),
                                      style: TextStyle(fontSize: 7.sp),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, LoginScreen.routeName);
                                        },
                                        child: Text(
                                          LocaleKeys.login.tr(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 7.sp,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
