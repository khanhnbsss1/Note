import 'package:get/get.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/pages/expense/model/transaction_type.dart';
import 'package:note/pages/history_transaction/model/transaction.dart';
import '../../expense/model/expenseType.dart';
import '../view/dummy.dart' as dummy;

class HistoryTransactionController extends GetxController {
  var dummyExpensesByDay = (dummy.dummyExpensesByDay).obs;
  var dummyIncomeByDay = (dummy.dummyIncomesByDay).obs;
  var isLineChart = false.obs;
  var isExpense = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void showLineChart() {
    isLineChart.value = !isLineChart.value;
  }

  void showExpenseStatic() {
    isExpense.value = !isExpense.value;
  }

  double getPercentage<T extends TransactionCategory>(T type) {
    int sum = 0;
    int total = 0;
    List<TransactionByDay> list = (type is ExpenseType) ? dummyExpensesByDay : dummyIncomeByDay;
    for (var e in list) {
      e.transactions?.forEach((e1) {
        if (e1.type == type) sum = sum + (e1.amount ?? 0);
        total = total + (e1.amount ?? 0);
      });
    }
    return sum / total;
  }

}
