class AppConfigs {
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
  static const dateTimeDisplayFormat3 = 'dd/MM';

  static const monthYearDisplay = 'MM/yyyy';
}