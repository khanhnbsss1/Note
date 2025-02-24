import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:note/service/local_database/shared_pref.dart';

class  ProfileController extends GetxController {
  SharedPreferencesIml sharedPreferencesIml = GetIt.instance.get();
  late dynamic enDarkMode;


  @override
  void onInit() {
    enDarkMode = sharedPreferencesIml.darkMode.obs;
    super.onInit();
  }



  Future<void> saveSettings(bool value) async {
    sharedPreferencesIml.saveDarkMode(value);
    update();
  }


}