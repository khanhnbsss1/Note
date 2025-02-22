import 'package:flutter/material.dart';
import 'package:note/images/images.dart';
import 'package:note/pages/expense/model/transaction_type.dart';

enum ExpenseType implements TransactionCategory {
  eat('Ăn uống', Colors.red, eatImg),
  clothes('Quần áo', Colors.purple, clothesImg),
  education('Giáo dục', Colors.green, educationImg),
  entertain('Giải trí', Colors.orange, entertainImg),
  move('Di chuyển', Colors.brown, moveImg),
  healthCare('Y tế', Colors.teal, healthCareImg),
  pet('Thú cưng', Colors.deepOrange, petImg),
  gift('Quà tặng', Colors.pink, giftImg),
  billElectric('Hoá đơn điện', Colors.yellow, billElectricImg),
  billInternet('Hoá đơn mạng', Colors.blue, billInternetImg),
  billWater('Hoá đơn nước', Colors.blueAccent, billWaterImg);

  @override
  final String label;
  @override
  final Color color;
  @override
  final String icon;

  const ExpenseType(this.label, this.color, this.icon);

  @override
  bool get isExpense => true;
}
