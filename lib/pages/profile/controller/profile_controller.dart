import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:note/service/local_database/shared_pref.dart';

import '../../../generated/l10n.dart';

class  ProfileController extends GetxController {
  SharedPreferencesIml sharedPreferencesIml = GetIt.instance.get();
  late dynamic enDarkMode;
  late dynamic isLanguage;

  @override
  void onInit() {
    enDarkMode = sharedPreferencesIml.darkMode.obs;
    isLanguage = sharedPreferencesIml.language.obs;
    super.onInit();
  }



  Future<void> saveSettings(bool value) async {
    await sharedPreferencesIml.saveDarkMode(value);
    update();
  }

  Future<void> saveLanguage(bool value) async {
    final newLanguage = value ? 1 : 0;
    await sharedPreferencesIml.saveLanguage(newLanguage);
    isLanguage.value = newLanguage;
    Get.updateLocale(S.delegate.supportedLocales[newLanguage]);
    update();
  }

}