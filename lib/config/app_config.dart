class AppDev {
  static const String BASE_URL = "https://uat-core.vgps.vn/api/";
  static const String SOCKET = "https://vgps.vn";
  static const String WEB_SOCKET_LOCAL = "https://vgps.vn/";
  static const String REPORT_URL = "https://report.vgps.vn/api/v1/";
  static const String IMAGE_URL = 'https://img.vgps.vn/';
  static const String IMAGE_URL_TEST = 'http://192.168.1.20:9000/';
}

class AppConfigs {
  static const String appName = 'VNCSS App';

  ///Paging
  static const pageSize = 20;
  static const pageSizeMax = 1000;

  ///Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'en';

  ///DateFormat
  static const dateAPIFormat = 'dd/MM/yyyy';
  static const dateAPIFormat2 = 'dd-MM-yyyy';
  static const dateDisplayFormat = 'dd/MM/yyyy';

  static const dateTimeAPIFormat =
      "MM/dd/yyyy'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeAPIFormat2 =
      "yyyy/MM/dd'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';
  static const dateTimeDisplayFormat1 = 'HH:mm dd/MM/yyyy';
  static const dateTimeDisplayFormat2 = 'HH:mm:ss dd/MM/yyyy';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Roboto';

  ///Max file
  static const maxAttachFile = 5;
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}
