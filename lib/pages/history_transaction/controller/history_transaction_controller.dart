import 'package:get/get.dart';
import 'package:note/pages/expense/model/transaction_type.dart';
import 'package:note/pages/history_transaction/model/transaction.dart';
import '../../expense/model/expenseType.dart';
import '../view/dummy.dart' as dummy;

class HistoryTransactionController extends GetxController {
  var expensesByDay = (dummy.dummyExpensesByDay).obs;
  var incomeByDay = (dummy.dummyIncomesByDay).obs;
  var timeChart = TimeChart.day.obs;
  var isLineChart = false.obs;
  var isExpense = true.obs;
  var count = 7.obs;

  void changeTimeChart(TimeChart type) {
    timeChart.value = type;
    // if (type == TimeChart.day) count.value = 7;
    // if (type == TimeChart.week) count.value = 8;
    // if (type == TimeChart.month) count.value = 12;
  }

  void showLineChart() {
    isLineChart.value = !isLineChart.value;
  }

  void showExpenseStatic() {
    isExpense.value = !isExpense.value;
  }

  double getIntervalForLineChart() {
    int max = 0;
    int min = 0;
    // if (timeChart.value == TimeChart.day) {
      if (isExpense.value) {
        for (var e in expensesByDay) {
          {
            if (max < e.totalExpense) max = e.totalExpense;
            if (min > e.totalExpense) min = e.totalExpense;
          }
        }
      } else {
        for (var e in incomeByDay) {
          {
            if (max < e.totalIncome) max = e.totalIncome;
            if (min > e.totalIncome) min = e.totalIncome;
          }
        }
      }
    // }
    return (max - min) / 5;
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
