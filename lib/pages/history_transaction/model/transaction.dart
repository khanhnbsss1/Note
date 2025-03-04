import 'package:note/pages/expense/model/expenseType.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/pages/expense/model/transaction_type.dart';

class Transaction {
  final TransactionCategory? type;
  final int? amount;
  final String? note;

  const Transaction({this.type, this.amount, this.note,});

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'amount': amount,
      'note': note,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: _parseTransactionCategory(json['type']),
      amount: json['amount'],
      note: json['note'],
    );
  }

  bool get isExpense{
   return type!.isExpense;
  }

  static TransactionCategory? _parseTransactionCategory(String? typeStr) {
    if (typeStr == null) return null;

    var parts = typeStr.split('.');
    if (parts.length < 2) return null;
    String enumName = parts[1];

    for (var type in ExpenseType.values) {
      if (type.name == enumName) return type;
    }
    for (var type in IncomeType.values) {
      if (type.name == enumName) return type;
    }

    return null;
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
    return transactions?.where((e) => e.isExpense).fold(0, (sum, t) => (sum??0) + (t.amount ?? 0)) ?? 0;
  }

  int get totalIncome {
    return transactions?.where((e) => !e.isExpense).fold(0, (sum, t) => (sum??0) + (t.amount ?? 0)) ?? 0;
  }
}

