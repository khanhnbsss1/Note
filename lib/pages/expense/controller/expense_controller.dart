import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/pages/expense/model/transaction_type.dart';
import 'package:note/pages/history_transaction/controller/history_transaction_controller.dart';
import 'package:note/pages/history_transaction/model/transaction.dart';

import '../model/expenseType.dart';

class ExpenseController extends GetxController {
  var selectedExpenseType = (ExpenseType.eat).obs;
  var selectedIncomeType = (IncomeType.salary).obs;
  var controller = Get.find<HistoryTransactionController>();
  final formKeyExpense = GlobalKey<FormState>();
  final formKeyIncome = GlobalKey<FormState>();

  void submitForm(
      {required bool isExpense, required String money, String? note}) {
    final formKey = isExpense ? formKeyExpense : formKeyIncome;
    if (formKey.currentState!.validate()) {
      if (isExpense) {
        createTransaction<ExpenseType>(
          selectedExpenseType.value,
          int.parse(money),
          note ?? "",
        );
      } else {
        createTransaction<IncomeType>(
          selectedIncomeType.value,
          int.parse(money),
          note ?? "",
        );
      }
    }
  }

  void changeSelectedType<T extends TransactionCategory>(T type) {
    if (type.isExpense) {
      selectedExpenseType.value = type as ExpenseType;
    } else {
      selectedIncomeType.value = type as IncomeType;
    }
  }

  void createTransaction<T extends TransactionCategory>(
    T type,
    int amount,
      String note,
  ) {
    List<TransactionByDay> list = (type.isExpense) ? controller.expensesByDay : controller.incomeByDay;
    int index = list.indexWhere((e) => isTheSameDay(e.date!, DateTime.now()));
    Transaction transaction = Transaction(note: note, amount: amount, type: type);
    if (index >= 0) {
      list[index].transactions?.add(transaction);
    } else {
      list.insert(0,
        TransactionByDay(
          date: DateTime.now(),
          transactions: [transaction],
        ),
      );
    }
    print('Thanh cong');
  }

  bool isTheSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.day == dateTime2.day &&
        dateTime1.month == dateTime2.month &&
        dateTime1.year == dateTime2.year;
  }
}
