import 'package:flutter/material.dart';
import 'package:note/images/images.dart';
import 'package:note/pages/expense/model/transaction_type.dart';

import '../../../generated/l10n.dart';

enum ExpenseType implements TransactionCategory {
  eat(Colors.red, eatImg),
  clothes(Colors.purple, clothesImg),
  education(Colors.green, educationImg),
  entertain(Colors.orange, entertainImg),
  move(Colors.brown, moveImg),
  healthCare(Colors.teal, healthCareImg),
  pet(Colors.deepOrange, petImg),
  gift(Colors.pink, giftImg),
  billElectric(Colors.yellow, billElectricImg),
  billInternet(Colors.blue, billInternetImg),
  billWater(Colors.blueAccent, billWaterImg);

  @override
  final Color color;
  @override
  final String icon;

  const ExpenseType(this.color, this.icon);

  @override
  String get label {
    switch (this) {
      case ExpenseType.eat:
        return S.current.expenseType_eat;
      case ExpenseType.clothes:
        return S.current.expenseType_clothes;
      case ExpenseType.education:
        return S.current.expenseType_education;
      case ExpenseType.entertain:
        return S.current.expenseType_entertain;
      case ExpenseType.move:
        return S.current.expenseType_move;
      case ExpenseType.healthCare:
        return S.current.expenseType_healthCare;
      case ExpenseType.pet:
        return S.current.expenseType_pet;
      case ExpenseType.gift:
        return S.current.expenseType_gift;
      case ExpenseType.billElectric:
        return S.current.expenseType_billElectric;
      case ExpenseType.billInternet:
        return S.current.expenseType_billInternet;
      case ExpenseType.billWater:
        return S.current.expenseType_billWater;
    }
  }

  @override
  bool get isExpense => true;
}
