import 'package:note/pages/expense/model/expenseType.dart';
import 'package:note/pages/expense/model/incomeType.dart';

class Transaction {
  final ExpenseType? expenseType;
  final IncomeType? incomeType;
  final int? amount;
  final String? note;

  const Transaction({this.expenseType, this.incomeType, this.amount, this.note});

  Map<String, dynamic> toJson() {
    return {
      'expenseType': expenseType?.name,
      'incomeType': incomeType?.name,
      'amount': amount,
      'note': note,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      expenseType: json['expenseType'] != null
          ? ExpenseType.values.byName(json['expenseType'])
          : null,
      incomeType: json['incomeType'] != null
          ? IncomeType.values.byName(json['incomeType'])
          : null,
      amount: json['amount'],
      note: json['note'],
    );
  }
}

class TransactionByDay {
  final DateTime? date;
  final List<Transaction>? transactions;

  const TransactionByDay({this.date, this.transactions});

  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'transactions': transactions?.map((t) => t.toJson()).toList(),
    };
  }

  factory TransactionByDay.fromJson(Map<String, dynamic> json) {
    return TransactionByDay(
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      transactions: json['transactions'] != null
          ? (json['transactions'] as List)
          .map((t) => Transaction.fromJson(t))
          .toList()
          : [],
    );
  }

  int get totalExpense {
    int total = 0;
    transactions?.forEach((e) {
      if (e.expenseType != null) total = total + (e.amount ?? 0);
    });
    return total;
  }

  int get totalIncome {
    int total = 0;
    transactions?.forEach((e) {
      if (e.incomeType != null) total = total + (e.amount ?? 0);
    });
    return total;
  }
}
