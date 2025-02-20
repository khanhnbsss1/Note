import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:note/images/images.dart';

enum ExpenseType {
  eat('Ăn uống'),
  clothes('Quần áo'),
  education('Giáo dục'),
  entertain('Giải trí'),
  move('Di chuyển'),
  healthCare('Y tế'),
  pet('Thú cưng'),
  gift('Quà tặng'),
  billElectric('Hoá đơn điện'),
  billInternet('Hoá đơn mạng'),
  billWater('Hoá đơn nước');

  final String label;

  const ExpenseType(this.label);
}

extension ExpenseTypeExtension on ExpenseType {
  String get icon {
    switch (this) {
      case ExpenseType.billElectric:
        return billElectricImg;
      case ExpenseType.billInternet:
        return billInternetImg;
      case ExpenseType.billWater:
        return billWaterImg;
      case ExpenseType.clothes:
        return clothesImg;
      case ExpenseType.eat:
        return eatImg;
      case ExpenseType.education:
        return educationImg;
      case ExpenseType.entertain:
        return entertainImg;
      case ExpenseType.gift:
        return giftImg;
      case ExpenseType.healthCare:
        return healthCareImg;
      case ExpenseType.move:
        return moveImg;
      case ExpenseType.pet:
        return petImg;
    }
  }

  Color get color {
    switch (this) {
      case ExpenseType.billElectric:
        return Colors.yellow.shade700;
      case ExpenseType.billInternet:
        return Colors.blue;
      case ExpenseType.billWater:
        return Colors.blue.shade300;
      case ExpenseType.clothes:
        return Colors.purple;
      case ExpenseType.eat:
        return Colors.red;
      case ExpenseType.education:
        return Colors.green.shade700;
      case ExpenseType.entertain:
        return Colors.orange;
      case ExpenseType.gift:
        return Colors.pink;
      case ExpenseType.healthCare:
        return Colors.teal;
      case ExpenseType.move:
        return Colors.brown;
      case ExpenseType.pet:
        return Colors.deepOrange;
    }
  }
}
