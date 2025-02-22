import 'package:get_it/get_it.dart';
import 'package:note/service/local_database/shared_pref.dart';

class AppConfigs {
  static final AppConfigs _instance = AppConfigs._internal();

  late final SharedPreferencesIml _sharedPreferencesIml;

  factory AppConfigs() {
    return _instance;
  }

  AppConfigs._internal() {
    _sharedPreferencesIml = GetIt.instance.get<SharedPreferencesIml>();
  }

  bool get darkMode => _sharedPreferencesIml.darkMode ?? false;

  /// Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'en';

  /// Date Format
  static const dateAPIFormat = 'dd/MM/yyyy';
  static const dateAPIFormat2 = 'dd-MM-yyyy';
  static const dateDisplayFormat = 'dd/MM/yyyy';

  static const dateTimeAPIFormat = "MM/dd/yyyy'T'hh:mm:ss.SSSZ";
  static const dateTimeAPIFormat2 = "yyyy/MM/dd'T'hh:mm:ss.SSSZ";
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';
  static const dateTimeDisplayFormat1 = 'HH:mm dd/MM/yyyy';
  static const dateTimeDisplayFormat2 = 'HH:mm:ss dd/MM/yyyy';
  static const dateTimeDisplayFormat3 = 'dd/MM';

  static const monthYearDisplay = 'MM/yyyy';
}
