import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:note/pages/homepage.dart';
import 'package:note/route/app_route.dart';
import 'package:note/service/local_database/shared_pref.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'bindings/initial_binding.dart';
import 'notification/notification_service.dart';

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  initDJ();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
}

final locator = GetIt.instance;

Future<void> initDJ() async {
  locator.registerLazySingleton(() => SharedPreferencesIml());
  await locator.get<SharedPreferencesIml>().onInit();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 830),
      builder: (context, widget) {
        return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: GetMaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Note pro',
              home: Homepage(),
              initialBinding: InitialBinding(),
              getPages: AppRoute.routes
            ));
      },
    );
  }
}
