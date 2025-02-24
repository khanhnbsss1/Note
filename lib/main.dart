import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:note/injector/injector.dart';
import 'package:note/pages/homepage.dart';
import 'package:note/pages/profile/controller/profile_controller.dart';
import 'package:note/route/app_route.dart';
import 'package:note/service/background_service/background_service.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note/service/background_service/work_manager.dart';
import 'package:note/service/local_database/shared_pref.dart';
import 'package:note/service/notification/notification_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:workmanager/workmanager.dart';
import 'bindings/initial_binding.dart';
import 'config/app_color.dart';
import 'config/app_config.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.initDJ();
  await NotificationService.init();
  await initializeBackGroundService();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  _initPackageInfo();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(ProfileController());
  runApp(
    MyApp(),
  );
}

Future<void> _initPackageInfo() async {
  PackageInfo info = await PackageInfo.fromPlatform();
  SharedPreferencesIml sharedPreferencesIml = GetIt.instance.get();
  sharedPreferencesIml.saveAppVersion(info.version);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final settingsController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 890),
      builder: (context, widget) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              return GetMaterialApp(
                theme: ThemeData(
                  scaffoldBackgroundColor: AppColor().background,
                  bottomAppBarTheme: BottomAppBarTheme(
                    color: AppColor().primary,
                  ),
                ),
                navigatorKey: navigatorKey,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: S.delegate.supportedLocales[settingsController.isLanguage.value],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                home: Homepage(),
                initialBinding: InitialBinding(),
                getPages: AppRoute.routes,
              );
            },
          ),
        );
      },
    );
  }
}
