import 'package:get/get.dart';
import 'package:note/pages/expense/model/incomeType.dart';
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

  double getPercentageExpense(ExpenseType type) {
    int sum = 0;
    int total = 0;
    for (var e in dummyExpensesByDay) {
      e.transactions?.forEach((e1) {
        if (e1.expenseType == type) sum = sum + (e1.amount ?? 0);
        total = total + (e1.amount ?? 0);
      });
    }
    return sum / total;
  }

  double getPercentageIncome(IncomeType type) {
    int sum = 0;
    int total = 0;
    for (var e in dummyIncomeByDay) {
      e.transactions?.forEach((e1) {
        if (e1.incomeType == type) sum = sum + (e1.amount ?? 0);
        total = total + (e1.amount ?? 0);
      });
    }
    return sum / total;
  }
}
