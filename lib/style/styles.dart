import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle get heading5 {
    return TextStyle(
      fontFamily: 'iCiel Helvetica',
      color: Colors.black,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get heading4 {
    return TextStyle(
      fontFamily: 'iCiel Helvetica',
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get heading3 {
    return TextStyle(
      fontFamily: 'iCiel Helvetica',
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get heading2 {
    return TextStyle(
      fontFamily: 'iCiel Helvetica',
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get subtitle {
    return TextStyle(
      fontFamily: 'iCiel Helvetica',
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get bodyText {
    return TextStyle(
      fontFamily: 'iCiel Helvetica',
      fontSize: 16.sp,
      color: Color(0xff34404B),
    );
  }

  static TextStyle get commonText {
    return TextStyle(
      fontFamily: 'iCiel Helvetica',
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get boldText {
    return TextStyle(
      fontFamily: 'iCiel Helvetica',
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get bodyMedium {
    return TextStyle(
      fontFamily: 'Proxima Nova',
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Color(0xff0C1132),
    );
  }
}
