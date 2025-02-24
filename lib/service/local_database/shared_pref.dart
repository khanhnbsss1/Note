import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../model/list_note.dart';



class SharedPreferencesIml {
  static const TOKEN = 'token';
  static const USER = 'user';
  static const COST = 'costType';
  static const IS_SAVE_PASS = 'isSavePass';
  static const ACCOUNT = 'account';
  static const PASSWORD = 'password';
  static const BIOMETRICS = 'biometric';
  static const NOTE = 'NOTE';
  static const DARKMODE = 'darkmode';
  static const VERSION = 'version';

  late SharedPreferences sharedPreferences;

  final AndroidOptions _getAndroidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  final _options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  late final FlutterSecureStorage storage;

  Future<void> onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    storage = FlutterSecureStorage(aOptions: _getAndroidOptions, iOptions: _options);
  }

  Future<void> saveNote(ListNote lists) async {
    await sharedPreferences.setString(NOTE, jsonEncode(lists));
  }

  ListNote? get listNote {
    final stringEncode = sharedPreferences.getString(NOTE);
    try {
      return ListNote.fromJson(jsonDecode(stringEncode!));
    } catch (e) {
      return null;
    }
  }

  Future<void> saveDarkMode(bool value) async {
    await sharedPreferences.setBool(DARKMODE, value);
  }

  bool get darkMode {
    return sharedPreferences.getBool(DARKMODE) ?? false;
  }

  Future<void> saveAppVersion(String version) async {
    await sharedPreferences.setString(VERSION, version);
  }

  String get version {
    final string = sharedPreferences.getString(VERSION);
    return string ?? "";
  }

  Future<void> saveLanguage(int value) async {
    await sharedPreferences.setInt(ACCOUNT, value);
  }

  int get language {
    return sharedPreferences.getInt(ACCOUNT) ?? 0;
  }

}
