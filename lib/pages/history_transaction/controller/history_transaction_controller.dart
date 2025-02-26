import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  var timeMilestone = (DateTime.now()).obs;

  @override
  void onInit() {
    getData(timeMilestone.value);
    super.onInit();
  }

  void getData(DateTime? timeMilestone) {
    if (timeMilestone == null) {
      expensesByDay.value = dummy.dummyExpensesByDay;
      incomeByDay.value = dummy.dummyIncomesByDay;
    } else {
      expensesByDay.value = _getTransactionInAMonth(dummy.dummyExpensesByDay,dateTime: timeMilestone);
      incomeByDay.value = _getTransactionInAMonth(dummy.dummyIncomesByDay,dateTime: timeMilestone);
    }
  }

  void changeMonth(DateTime time) {
    timeMilestone.value = time;
    getData(timeMilestone.value);
  }

  List<TransactionByDay> _getTransactionInAMonth(List<TransactionByDay> data,
      {DateTime? dateTime}) {
    dateTime ??= DateTime.now();

    return data.where((entry) {
      return (entry.date!.month == dateTime!.month && entry.date!.year == dateTime.year) ;
    }).toList();
  }

  TransactionByDay get spendingThisMonth {
    final DateTime now = DateTime.now();
    final DateTime startOfMonth = DateTime(now.year, now.month);

    return TransactionByDay(
      date: startOfMonth,
      transactions:
        _getSpendingThisMonth()
      ,
    );
  }

  List<Transaction> _getSpendingThisMonth<T extends TransactionCategory>() {
    final DateTime now = DateTime.now();
    final DateTime startOfMonth = DateTime(now.year, now.month);

    final Map<T, int> totalsByType = {};

    for (var entry in expensesByDay.where((e) =>
    e.date!.year == startOfMonth.year && e.date!.month == startOfMonth.month)) {
      for (var transaction in entry.transactions!) {
        final T type = transaction.type as T;
        totalsByType[type] = (totalsByType[type] ?? 0) + transaction.amount!;
      }
    }

    for (var entry in incomeByDay.where((e) =>
    e.date!.year == startOfMonth.year && e.date!.month == startOfMonth.month)) {
      for (var transaction in entry.transactions!) {
        final T type = transaction.type as T;
        totalsByType[type] = (totalsByType[type] ?? 0) + transaction.amount!;
      }
    }

    return totalsByType.entries.map((entry) {
      return Transaction(
        type: entry.key,
        amount: entry.value,
        note: "${entry.key.toString().split('.').last} total for ${now.month}/${now.year}",
      );
    }).toList();
  }

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
    if (timeChart.value == TimeChart.day) {
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
    } else {
      return 10000000;
    }
    return (max - min) / 5;
  }

  double getPercentage<T extends TransactionCategory>(T type,
      {TransactionByDay? listData}) {
    int sum = 0;
    int total = 0;
    List<TransactionByDay> list =(type is ExpenseType) ? expensesByDay : incomeByDay;
    for (var e in list) {
      e.transactions?.forEach((e1) {
        if (e1.type == type) sum = sum + (e1.amount ?? 0);
        total = total + (e1.amount ?? 0);
      });
    }
    return sum / total;
  }

  double getPercentageByMonth<T extends TransactionCategory>(T type, TransactionByDay? listData) {
    try {
      int sum = (type.isExpense) ? listData!.totalExpense : listData!.totalIncome;
      int spentIndex = listData.transactions!.indexWhere((e) => e.type == type);
      return listData.transactions![spentIndex].amount! / sum;
    } catch (e) {
      return 0;
    }
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

  List<TransactionByDay> getTransactionByMonth(List<TransactionByDay> listTransaction) {
    final Map<DateTime, int> monthlyTotals = {};

    for (var dayEntry in listTransaction) {
      final DateTime monthKey = DateTime(dayEntry.date!.year, dayEntry.date!.month); // Year and month only
      final int totalForDay = dayEntry.transactions!.fold(
        0,
            (sum, transaction) => sum + transaction.amount!,
      );
      monthlyTotals[monthKey] = (monthlyTotals[monthKey] ?? 0) + totalForDay;
    }

    List<TransactionByDay> monthlyTransactions = monthlyTotals.entries.map((entry) {
      return TransactionByDay(
        date: entry.key,
        transactions: [
          Transaction(
            type: listTransaction.first.transactions!.first.type,
            amount: entry.value,
            note: "Monthly total for ${entry.key.month}/${entry.key.year}",
          ),
        ],
      );
    }).toList();

    // Sort by date
    monthlyTransactions.sort((a, b) => a.date!.compareTo(b.date!));

    return monthlyTransactions;
  }
}

enum TimeChart {
  day('Ngày'),
  week('Tuần'),
  month('Tháng');

  final String label;

  const TimeChart(this.label);
}
