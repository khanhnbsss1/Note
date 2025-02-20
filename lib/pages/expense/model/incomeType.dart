import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:note/images/images.dart';

enum IncomeType {
  salary('Tiền lương'),
  extra('Tiền thưởng'),
  invest('Tiền đầu tư'),
  other('Tiền khác');

  final String label;

  const IncomeType(this.label);
}

extension IncomeTypeExtension on IncomeType {
  String get icon {
    switch (this) {
      case IncomeType.salary:
        return salaryImg;
      case IncomeType.extra:
        return extraMoneyImg;
      case IncomeType.invest:
        return investImg;
      case IncomeType.other:
        return otherMoneyImg;
    }
  }

  Color get color {
    switch (this) {
      case IncomeType.salary:
        return Colors.yellow.shade700;
      case IncomeType.extra:
        return Colors.blue;
      case IncomeType.invest:
        return Colors.blue.shade300;
      case IncomeType.other:
        return Colors.purple;
    }
  }
}