// ignore_for_file: import_of_legacy_library_into_null_safe, unnecessary_null_comparison, avoid_print

import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/logic/bloc/login/login_bloc_bloc.dart';
import 'package:charity_management_system/view/screens/signUp_screen/sign_up_screen.dart';
import 'package:charity_management_system/view/widgets/email_filed.dart';
import 'package:charity_management_system/view/widgets/main_buttom.dart';
import 'package:charity_management_system/view/widgets/password-filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';

import '../../../api/google_signing_api.dart';
import '../home_screen/root_screen_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = 'login_screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _loginButtonPressed() {
      String email = _emailController.text.trim();
      String password = _passwordController.text;

      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        email,
        password,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          ToastContext().init(context);
          Toast.show(
            tr('unexpected_error'),
            duration: Toast.lengthLong,
            gravity: Toast.bottom,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).hoverColor,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFaliure) {
              var snackBar = const SnackBar(
                content: Text('Some Error , Login Opreation is Faild'),
                duration: Duration(milliseconds: 1000),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is LoginInitial) {
              Navigator.pop(context);
            }
          },
          child: SafeArea(
            child: Stack(
              children: [
                Image.asset("assets/images/Mask_Group.png", fit: BoxFit.cover),
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 2900,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: defaultPadding,
                            ),
                            AspectRatio(
                              aspectRatio: 3 / 1.2,
                              child: Image.asset("assets/images/sign_in.png"),
                            ),
                            Text(
                              'login'.tr(),
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                            Text('subtitle_login'.tr(),
                                style: TextStyle(
                                    fontSize: 7.sp, color: Colors.white)),
                            const SizedBox(
                              height: defaultPadding,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        //  height: 400,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                      horizontal: defaultPadding * 2),
                                  child: Text(
                                    'email'.tr(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextFormEditing(
                                  hintText: "09xxxxxxxx / Email@domin.com",
                                  controller: _emailController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: tr('The field is required')),
                                    EmailValidator(
                                        errorText:
                                            '  ادخل البريد الإلكتروني الصحيح')
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding,
                                      horizontal: defaultPadding * 2),
                                  child: Text(
                                    'password'.tr(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                PasswordFormFiled(
                                    hintText: 'password'.tr(),
                                    controller: _passwordController,
                                    validator: MultiValidator(
                                      [
                                        RequiredValidator(
                                            errorText:
                                                tr('The field is required')),
                                        MaxLengthValidator(
                                          15,
                                          errorText:
                                              'لا يمكن إدخال أكثر من 15 حرف',
                                        ),
                                        MinLengthValidator(
                                          7,
                                          errorText:
                                              'لا يمكن إدخال أقل من 7 حرف',
                                        ),
                                        EmailValidator(
                                          errorText:
                                              '  ادخل  كلمة المرور الصحيح',
                                        )
                                      ],
                                    ),
                                    icon: Icons.lock),
                                const SizedBox(
                                  height: defaultPadding * 1.5,
                                ),
                                BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    if (state is LoginLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primary1,
                                          strokeWidth: 2,
                                        ),
                                      );
                                    }

                                    return MainButtom(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          _loginButtonPressed();
                                        }
                                      },
                                      //  textcolor: AppColors.textLigth,
                                      title: 'login'.tr(),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                MainButtom(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RootScreenState()));
                                  },
                                  // textcolor: AppColors.textDark,
                                  title: 'login_as_guest'.tr(),
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'info_account'.tr(),
                                      style: TextStyle(
                                        fontSize: 7.sp,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          SignUpScreen.routeName,
                                        );
                                      },
                                      child: Text(
                                        'info_account2'.tr(),
                                        style: TextStyle(
                                            fontSize: 7.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signInWithGoogle() async {
    final user = await GoogleSignInApi.login();
    String? token;

    user!.authentication.then((googleKey) {
      print(googleKey.accessToken);
      token = googleKey.accessToken;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr('un_expected_error')),
          ),
        );
      } else {
        if (token != null) {
          print('Google Token ()=> $token');
          context.read<LoginBloc>().add(LoginWithGooglePressed(token: token!));
        }
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => LoggedInScreen(user: user)),
        // );
      }
    });
  }
}
