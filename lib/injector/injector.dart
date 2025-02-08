import 'package:get_it/get_it.dart';

import '../pages/list_notes/controller/list_notes_controller.dart';
import '../service/local_database/shared_pref.dart';

class Injector {
  static final locator = GetIt.instance;

  @pragma('vm:entry-point')
  static Future<void> initDJ() async {
    locator.registerLazySingleton<SharedPreferencesIml>(() => SharedPreferencesIml());

    await locator<SharedPreferencesIml>().onInit();

    locator.registerLazySingleton<ListNotesController>(() => ListNotesController());
  }
}
