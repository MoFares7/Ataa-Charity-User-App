import 'package:charity_management_system/configs/size.dart';
import 'package:charity_management_system/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../logic/provider/themeProvider.dart';

enum Locations { ar, en }

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var languge = 'ar';
  bool isEnglish = true;

  bool isDarkModeEnabled = false;

  //ValueNotifier<String> buttonClickedTimes = ValueNotifier('ar');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(    leading: IconButton(
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
            LocaleKeys.settings.tr(),
            style: TextStyle(
                  color: Theme.of(context).dividerColor, fontSize: 12.sp),
          ),
        ),
        body: SingleChildScrollView(
            child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: defaultPadding / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Icon(Icons.language),
                              const SizedBox(
                                width: defaultPadding * 2,
                              ),
                              Text('language'.tr()),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: DropdownButtonFormField<Locale>(
                            alignment: Alignment.centerRight,
                            decoration: const InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            value: context.locale,
                            onChanged: (newLanguage) async {
                              context.setLocale(newLanguage!);
                              OneSignal.shared
                                  .setLanguage(newLanguage.languageCode);
                            },
                            items: const [
                              DropdownMenuItem(
                                child: Text('Arabic'),
                                value: Locale('ar'),
                              ),
                              DropdownMenuItem(
                                child: Text('English'),
                                value: Locale('en'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    ListTile(
                        title: Text(
                          LocaleKeys.mode.tr(),
                        ),
                        leading: const Icon(
                          Icons.brightness_2,
                        ),
                        trailing: const DarkModeSwitch()),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                   
                  ],
                ))));
  }
}

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      
      },
    );
  }
}
