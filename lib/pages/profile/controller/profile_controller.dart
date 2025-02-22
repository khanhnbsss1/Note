import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:note/service/local_database/shared_pref.dart';

class  ProfileController extends GetxController {
  late SharedPreferencesIml sharedPreferencesIml;
  var enDarkMode = false.obs;


  @override
  void onInit() {
    sharedPreferencesIml = GetIt.instance.get();
    enDarkMode.value = sharedPreferencesIml.darkMode;
    super.onInit();
  }



  Future<void> saveSettings(bool value) async {
    sharedPreferencesIml.saveDarkMode(value);
    update();
  }


}