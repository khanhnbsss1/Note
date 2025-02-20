import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/pages/history_transaction/controller/history_transaction_controller.dart';
import 'package:note/pages/history_transaction/model/transaction.dart';

import '../model/expenseType.dart';

class ExpenseController extends GetxController {
  var selectedExpenseType = (ExpenseType.eat).obs;
  var selectedIncomeType = (IncomeType.salary).obs;
  var controller = Get.find<HistoryTransactionController>();

  @override
  void onInit() {
    super.onInit();
  }

  void changeSelectedExpenseType(ExpenseType type) {
    selectedExpenseType.value = type;
  }

  void changeSelectedIncomeType(IncomeType type) {
    selectedIncomeType.value = type;
  }

  void createTransaction(IncomeType type, int amount,) {
    int index = controller.dummyIncomeByDay.indexWhere((e) => isTheSameDay(e.date!, DateTime.now()));
    controller.dummyIncomeByDay[index].transactions?.add(Transaction(
      note: 'Test Test Test',
      amount: amount,
      incomeType: IncomeType.other
    ));
    controller.dummyIncomeByDay[index].transactions;
    print('Thanh cong');
  }

  bool isTheSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.day == dateTime2.day &&
            dateTime1.month == dateTime2.month &&
            dateTime1.year == dateTime2.year;
  }
}
