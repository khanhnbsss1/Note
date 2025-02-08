import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/injector/injector.dart';
import 'package:note/pages/homepage.dart';
import 'package:note/route/app_route.dart';
import 'package:note/service/background_service/background_service.dart';
import 'package:get/get.dart';
import 'package:note/service/background_service/work_manager.dart';
import 'package:note/service/notification/notification_service.dart';
import 'package:workmanager/workmanager.dart';
import 'bindings/initial_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.initDJ();
  await NotificationService.init();
  await initializeBackGroundService();
  Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
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
