import 'package:flutter/material.dart';
import 'package:note/pages/expense/model/transaction_type.dart';
import '../../../generated/l10n.dart';
import '../../../images/images.dart';

enum IncomeType implements TransactionCategory {
  salary(Colors.amber, salaryImg,),
  extra(Colors.blue, extraMoneyImg,),
  invest(Colors.green, investImg,),
  other(Colors.purple, otherMoneyImg,);

  @override
  final String icon;
  @override
  final Color color;

  const IncomeType(this.color, this.icon, );

  @override
  String get label {
    switch (this) {
      case IncomeType.salary:
        return S.current.incomeType_salary;
      case IncomeType.extra:
        return S.current.incomeType_extra;
      case IncomeType.invest:
        return S.current.incomeType_invest;
      case IncomeType.other:
        return S.current.incomeType_other;
    }
  }

  @override
  bool get isExpense => false;
}