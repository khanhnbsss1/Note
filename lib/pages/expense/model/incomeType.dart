import 'package:flutter/material.dart';
import 'package:note/pages/expense/model/transaction_type.dart';

import '../../../images/images.dart';

enum IncomeType implements TransactionCategory {
  salary('Tiền lương', salaryImg, Colors.amber),
  extra('Tiền thưởng', extraMoneyImg, Colors.blue),
  invest('Tiền đầu tư', investImg, Colors.green),
  other('Tiền khác', otherMoneyImg, Colors.purple);

  @override
  final String label;
  @override
  final Color color;
  @override
  final String icon;

  const IncomeType(this.label, this.icon, this.color);

  @override
  bool get isExpense => false;
}
