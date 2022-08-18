// ignore_for_file: unused_local_variable
import 'package:charity_management_system/configs/helpers.dart';
import 'package:charity_management_system/configs/routeconfigs.dart';
import 'package:charity_management_system/configs/theme.dart';
import 'package:charity_management_system/logic/bloc/login/login_bloc_bloc.dart';
import 'package:charity_management_system/logic/bloc/logout/logout_bloc_bloc.dart';
import 'package:charity_management_system/logic/bloc/registration/registration_bloc_bloc.dart';
import 'package:charity_management_system/logic/gifts/gifts_bloc.dart';
import 'package:charity_management_system/logic/navigation/navigation_bloc.dart';
import 'package:charity_management_system/view/screens/home_screen/root_screen_state.dart';
import 'package:charity_management_system/view/screens/login_screen/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'data/repositories/auth_repository.dart';
import 'data/shared/shared_prefs_repository.dart';
import 'logic/bloc/auth/auth_bloc_bloc.dart';
import 'logic/provider/themeProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Helpers.stripePublishableKey;

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: 'assets/translation',
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      // assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        const FlutterSecureStorage storage = FlutterSecureStorage();
        final AuthRepository authRepository = AuthRepository(storage);
        final SharedPrefsRepository prefsRepository =
            SharedPrefsRepository(storage);
        return MultiBlocProvider(
            providers: [
              BlocProvider<GiftsBloc>(
                create: (context) => GiftsBloc()..add(GetGifts()),
              ),
              BlocProvider(
                create: (_) => AuthBloc(
                  authRepository,
                )..add(AppStarted()),
              ),
              BlocProvider(
                create: (context) => RegistrationBloc(
                  authRepository: authRepository,
                  authBloc: context.read<AuthBloc>(),
                ),
              ),
              BlocProvider(
                create: (context) => LoginBloc(
                  authRepository: authRepository,
                  authBloc: context.read<AuthBloc>(),
                ),
              ),
              BlocProvider(
                  create: (context) => LogoutBloc(
                      authRepository: authRepository,
                      authBloc: context.read<AuthBloc>(),
                      sharedPrefsRepository: prefsRepository)),
              BlocProvider(create: (context) => NavigationBloc()),
            ],
            child: Sizer(
              builder: (context, orientation, deviceType) {
                return (MaterialApp(
                    supportedLocales: context.supportedLocales,
                    localizationsDelegates: context.localizationDelegates,
                    locale: context.locale,
                    title: 'Charity Management System',
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: AppRouter.onGenerateRoute,
                    theme: AppTheme.light(),
                    darkTheme: AppTheme.dark(),
                    themeMode: themeProvider.themeMode,
                    // themeMode: ThemeMode.light,
                    home: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is AuthAuthenticated) {
                            return const RootScreenState();
                          }
                          if (state is AuthUnauthenticated) {
                            return const LoginScreen();
                          }
                          return const Scaffold(
                            body: SafeArea(
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary1,
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                          );
                        })));
              },
            ));
      });

  @override
  void initState() {
    super.initState();
    initializeOneSignal();
  }

  Future<void> initializeOneSignal() async {
    await OneSignal.shared.setAppId('78c6530d-8bb1-4559-9713-08c875e25b3e');
    await OneSignal.shared.setLogLevel(
      OSLogLevel.warn,
      OSLogLevel.none,
    );
  }
}
