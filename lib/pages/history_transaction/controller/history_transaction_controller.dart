import 'package:get/get.dart';
import 'package:note/pages/expense/model/transaction_type.dart';
import 'package:note/pages/history_transaction/model/transaction.dart';
import '../../expense/model/expenseType.dart';
import '../view/dummy.dart' as dummy;

class HistoryTransactionController extends GetxController {
  var expensesByDay = (dummy.dummyExpensesByDay).obs;
  var incomeByDay = (dummy.dummyIncomesByDay).obs;
  var timeChart = TimeChart.week.obs;
  var isLineChart = false.obs;
  var isExpense = true.obs;

  void showLineChart() {
    isLineChart.value = !isLineChart.value;
  }

  void showExpenseStatic() {
    isExpense.value = !isExpense.value;
  }

  double getPercentage<T extends TransactionCategory>(T type) {
    int sum = 0;
    int total = 0;
    List<TransactionByDay> list = (type is ExpenseType) ? expensesByDay : incomeByDay;
    for (var e in list) {
      e.transactions?.forEach((e1) {
        if (e1.type == type) sum = sum + (e1.amount ?? 0);
        total = total + (e1.amount ?? 0);
      });
    }
    return sum / total;
  }

  int getTotalExpenseForMonth(DateTime month) {
    return expensesByDay
        .where((t) => t.date?.year == month.year && t.date?.month == month.month)
        .fold(0, (sum, t) => sum + t.totalExpense);
  }

  int getTotalIncomeForMonth(DateTime month) {
    return incomeByDay
        .where((t) => t.date?.year == month.year && t.date?.month == month.month)
        .fold(0, (sum, t) => sum + t.totalIncome);
  }
}

enum TimeChart {
  day('Ngày'),
  week('Tuần'),
  month('Tháng');

  final String label;

  const TimeChart(this.label);
}
