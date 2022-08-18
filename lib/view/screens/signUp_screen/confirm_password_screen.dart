import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/view/screens/home_screen/root_screen_state.dart';
import 'package:charity_management_system/view/widgets/password-filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

import '../../../configs/size.dart';
import '../../widgets/main_buttom.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary1,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/Mask_Group.png",
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    AspectRatio(
                        aspectRatio: 3 / 1.2,
                        child: Image.asset("assets/images/sign_in.png")),
                    Text(
                      tr('login'),
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                    Text(
                        " قم بتسجيل دخولك وساهم في بمساعدة ماتستطيع من ذوي الاحتياج",
                        style: TextStyle(fontSize: 8.sp, color: Colors.white)),
                    const SizedBox(
                      height: defaultPadding,
                    )
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    //  height: 400,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: defaultPadding * 2,
                                  horizontal: defaultPadding * 2),
                              child: Text("ادحل كلمة المرور "),
                            ),
                            PasswordFormFiled(
                                hintText: tr('password'),
                                controller: _passwordController,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: 'الحقل مطلوب'),
                                  EmailValidator(
                                      errorText: '  ادخل  كلمة المرور الصحيح')
                                ]),
                                icon: Icons.lock),
                            const SizedBox(
                              height: defaultPadding * 1.5,
                            ),
                            PasswordFormFiled(
                                hintText: "تأكيد كلمة المرور",
                                controller: _confirmpasswordController,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: 'الحقل مطلوب'),
                                  EmailValidator(
                                      errorText: '  ادخل  كلمة المرور الصحيح')
                                ]),
                                icon: Icons.lock),
                            const SizedBox(
                              height: defaultPadding * 1.5,
                            ),
                            MainButtom(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RootScreenState()));
                                }
                              },
                              //   textcolor: AppColors.textLigth,
                              title: "إنشاء حساب ",
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
    );
  }
}
