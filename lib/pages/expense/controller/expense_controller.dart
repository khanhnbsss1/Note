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

  void changeSelectedExpenseType(ExpenseType type) {
    selectedExpenseType.value = type;
  }

  void changeSelectedIncomeType(IncomeType type) {
    selectedIncomeType.value = type;
  }

  void createTransaction<T extends TransactionCategory>(
    T type,
    int amount,
  ) {
    List<TransactionByDay> list = (type == ExpenseType) ? controller.dummyExpensesByDay : controller.dummyIncomeByDay;
    int index = list.indexWhere((e) => isTheSameDay(e.date!, DateTime.now()));
    Transaction transaction = Transaction(note: 'Test Test Test', amount: amount, type: IncomeType.other);
    if (index >= 0) {
      list[index].transactions?.add(transaction);
    } else {
      list.add(
        TransactionByDay(
          date: DateTime.now(),
          transactions: [transaction],
        ),
      );
    }
    controller.dummyIncomeByDay[index].transactions;
    print('Thanh cong');
  }

  bool isTheSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.day == dateTime2.day &&
        dateTime1.month == dateTime2.month &&
        dateTime1.year == dateTime2.year;
  }
}
