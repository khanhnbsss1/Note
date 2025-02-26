import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:note/service/local_database/shared_pref.dart';

import '../../../generated/l10n.dart';

class  ProfileController extends GetxController {
  SharedPreferencesIml sharedPreferencesIml = GetIt.instance.get();
  late RxBool enDarkMode;
  late RxString languageCode;
  late RxInt monthTime;

  @override
  void onInit() {
    enDarkMode = sharedPreferencesIml.darkMode.obs;
    languageCode = sharedPreferencesIml.language.obs;
    monthTime = sharedPreferencesIml.monthTime.obs;
    super.onInit();
  }



  Future<void> saveSettings(bool value) async {
    await sharedPreferencesIml.saveDarkMode(value);
    update();
  }

  Future<void> saveLanguage(String languageCode) async {
    await sharedPreferencesIml.saveLanguage(languageCode);
    this.languageCode.value = languageCode;
    Get.updateLocale(S.delegate.supportedLocales.where((e) => e.languageCode == languageCode).first);
    update();
  }

  Future<void> saveMonthTime(int value) async {
    await sharedPreferencesIml.saveMonthTime(value);
    monthTime.value = value;
  }
}