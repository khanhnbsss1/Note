import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note/config/app_config.dart';
import 'package:note/pages/expense/model/expenseType.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/pages/history_transaction/model/transaction.dart';
import 'package:note/style/styles.dart';
import 'package:note/util/date_utils.dart';
import 'package:note/util/string_format.dart';

import '../controller/history_transaction_controller.dart';

class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});

  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  HistoryTransactionController controller = Get.find();
  double smallestPercentToShowOnChart = 0.1;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => SizedBox(
              height: 100.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        controller.showLineChart();
                      },
                      icon: Icon(
                        controller.isLineChart.value
                            ? Icons.stacked_line_chart
                            : Icons.pie_chart,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        controller.showExpenseStatic();
                      },
                      icon: Icon(
                        controller.isExpense.value
                            ? Icons.shopping_cart
                            : Icons.account_balance,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Obx(
              () => (controller.isLineChart.value) ? lineChart() : pieChart(),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          TabBar(
            onTap: (value) {
              tabController.animateTo(value);
            },
            controller: tabController,
            indicatorColor: Colors.white,
            dividerColor: Colors.transparent,
            enableFeedback: false,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                child: Text(
                  'Chi tiêu',
                  style: AppTextStyle.commonText.copyWith(color: Colors.white),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.account_balance,
                  color: Colors.white,
                ),
                child: Text(
                  'Thu nhập',
                  style: AppTextStyle.commonText.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Flexible(
            child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  expenseTab(),
                  incomeTab(),
                ]),
          ),
        ],
      ),
    );
  }

  Widget expenseTab() {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index1) {
        return Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
                title: dayTile(controller.dummyExpensesByDay[index1].date!),
                showTrailingIcon: false,
                initiallyExpanded: true,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.dummyExpensesByDay[index1].transactions!.length,
                    itemBuilder: (context, index2) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 12.h),
                        child: expenseItem(
                            controller.dummyExpensesByDay[index1].transactions![index2]),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 16.h,
        );
      },
      itemCount: controller.dummyExpensesByDay.length,
    );
  }

  Widget incomeTab() {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index1) {
        return Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
                title: dayTile(controller.dummyIncomeByDay[index1].date!),
                showTrailingIcon: false,
                initiallyExpanded: true,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.dummyIncomeByDay[index1].transactions!.length,
                    itemBuilder: (context, index2) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 12.h),
                        child: incomeItem(
                            controller.dummyIncomeByDay[index1].transactions![index2]),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 16.h,
        );
      },
      itemCount: controller.dummyIncomeByDay.length,
    );
  }

  Widget dayTile(DateTime date) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      color: Colors.grey.withValues(alpha: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateUtilsFormat.toDateTimeString(date,
                format: AppConfigs.dateAPIFormat),
            style: AppTextStyle.commonText.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            DateUtilsFormat.dayOfWeekFormat(date.weekday),
            style: AppTextStyle.commonText.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseItem(Transaction transaction) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          transaction.expenseType != null
              ? transaction.expenseType!.icon
              : transaction.incomeType!.icon,
          height: 100.h,
        ),
      ),
      title: Text(
        transaction.expenseType != null
            ? transaction.expenseType!.label
            : transaction.incomeType!.label,
        style: AppTextStyle.commonText.copyWith(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        transaction.note ?? "",
        style: AppTextStyle.commonText
            .copyWith(color: Colors.white, fontSize: 12.sp),
      ),
      trailing: Text(
        '${transaction.expenseType != null ? StringFormatter.formatNumber(transaction.amount) : '-${StringFormatter.formatNumber(transaction.amount)}'} đ',
        style: AppTextStyle.commonText.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget incomeItem(Transaction transaction) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          transaction.incomeType!.icon,
          height: 100.h,
        ),
      ),
      title: Text(
        transaction.incomeType!.label,
        style: AppTextStyle.commonText.copyWith(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        transaction.note ?? "",
        style: AppTextStyle.commonText
            .copyWith(color: Colors.white, fontSize: 12.sp),
      ),
      trailing: Text(
        '${StringFormatter.formatNumber(transaction.amount)} đ',
        style: AppTextStyle.commonText.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget lineChart() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white.withValues(alpha: 0.2),
        ),
        height: 200.h,
        padding: EdgeInsets.only(left: 20.w,right: 40.w, top: 16.h, bottom: 16.h),
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: false,
              )),
              topTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: false,
              )),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  maxIncluded: true,
                  minIncluded: false,
                  reservedSize: 40,
                  interval: (!controller.isExpense.value) ? 1000000 : 100000,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${(value ~/ 1000)}K',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.6)),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < controller.dummyExpensesByDay.length) {
                      return Text(
                        DateUtilsFormat.toDateTimeString(
                            controller.dummyExpensesByDay[index].date!,
                            format: AppConfigs.dateTimeDisplayFormat3),
                        style: AppTextStyle.commonText.copyWith(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12.sp),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  reservedSize: 22,
                ),
              ),
            ),
            lineBarsData: [
              // Expenses Line (Red)
              (controller.isExpense.value)
                  ? LineChartBarData(
                      spots: controller.dummyExpensesByDay.map((e) {
                        int totalExpense = e.totalExpense;
                        return FlSpot(
                            controller.dummyExpensesByDay.indexOf(e).toDouble(),
                            totalExpense.toDouble());
                      }).toList(),
                      isCurved: false,
                      color: Colors.red,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                          show: true,
                          color: Colors.red.withValues(alpha: 0.3)),
                    )
                  :

                  // Income Line (Green)
                  LineChartBarData(
                      spots: controller.dummyIncomeByDay.map((e) {
                        int totalIncome = e.totalIncome;
                        return FlSpot(controller.dummyIncomeByDay.indexOf(e).toDouble(),
                            totalIncome.toDouble());
                      }).toList(),
                      isCurved: false,
                      color: Colors.green,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                          show: true, color: Colors.green.withValues(alpha: 0.3)),
                    ),
            ],
          ),
        ));
  }

  int touchedIndex = -1;

  Widget pieChart() {
    return Row(
      children: [
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
          ),
          height: 200.h,
          width: 250.w,
          child: PieChart(
            curve: Curves.easeInOutCubic,
            duration: Duration(milliseconds: 200),
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: true,
              ),
              sections: controller.isExpense.value ? listSectionExpense() : listSectionIncome(),
            ),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...(controller.isExpense.value) ?  ExpenseType.values
                  .where((e) => controller.getPercentageExpense(e) > smallestPercentToShowOnChart)
                  .map((e) => indicatorExpense(e))
                  .toList() : IncomeType.values
                  .where((e) => controller.getPercentageIncome(e) > smallestPercentToShowOnChart)
                  .map((e) => indicatorIncome(e))
                  .toList(),
              ...[leftIndicator()],
            ]
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> listSectionExpense() {
    int index = -1;
    double percentLeft = 1;
    List<PieChartSectionData?> widget = ExpenseType.values.map((e) {
      double percent = controller.getPercentageExpense(e);
      if (percent > smallestPercentToShowOnChart) {
        percentLeft -= percent;
        index++;
        return PieChartSectionData(
          showTitle: true,
          value: percent,
          color: e.color,
          title: '${(percent * 100).toStringAsFixed(0)}%',
          titleStyle: TextStyle(color: Colors.white),
          radius: (touchedIndex == index) ? 40 : 30,
          // badgeWidget: Text(
          //   e.label,
          //   style: AppTextStyle.commonText.copyWith(
          //     color: Colors.white
          //   ),
          // ),
          // badgePositionPercentageOffset: 2,
        );
      }
      return null;
    }).toList();
    if (percentLeft > 0.01) {
      widget.add(PieChartSectionData(
      showTitle: true,
      value: percentLeft,
      color: Colors.lime,
      title: '${(percentLeft * 100).toStringAsFixed(0)}%',
      titleStyle: TextStyle(color: Colors.white),
      radius: (touchedIndex == index) ? 40 : 30,
      // badgeWidget: Text(
      //   e.label,
      //   style: AppTextStyle.commonText.copyWith(
      //     color: Colors.white
      //   ),
      // ),
      // badgePositionPercentageOffset: 2,
    ));
    }
    return widget.whereType<PieChartSectionData>().toList();
  }

  List<PieChartSectionData> listSectionIncome() {
    int index = -1;
    double percentLeft = 1;
    List<PieChartSectionData?> widget = IncomeType.values.map((e) {
      double percent = controller.getPercentageIncome(e);
      if (percent > smallestPercentToShowOnChart) {
        percentLeft -= percent;
        index++;
        return PieChartSectionData(
          showTitle: true,
          value: percent,
          color: e.color,
          title: '${(percent * 100).toStringAsFixed(0)}%',
          titleStyle: TextStyle(color: Colors.white),
          radius: (touchedIndex == index) ? 40 : 30,
          // badgeWidget: Text(
          //   e.label,
          //   style: AppTextStyle.commonText.copyWith(
          //     color: Colors.white
          //   ),
          // ),
          // badgePositionPercentageOffset: 2,
        );
      }
      return null;
    }).toList();
    if (percentLeft > 0.01) {
      widget.add(PieChartSectionData(
      showTitle: true,
      value: percentLeft,
      color: Colors.lime,
      title: '${(percentLeft * 100).toStringAsFixed(0)}%',
      titleStyle: TextStyle(color: Colors.white),
      radius: (touchedIndex == index) ? 40 : 30,
      // badgeWidget: Text(
      //   e.label,
      //   style: AppTextStyle.commonText.copyWith(
      //     color: Colors.white
      //   ),
      // ),
      // badgePositionPercentageOffset: 2,
    ));
    }
    return widget.whereType<PieChartSectionData>().toList();
  }

  Widget indicatorIncome(IncomeType type) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            height: 20.r,
            width: 20.r,
            decoration: BoxDecoration(
              color: type.color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Flexible(
            child: Text(
              type.label,
              style: AppTextStyle.commonText.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget indicatorExpense(ExpenseType type) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            height: 20.r,
            width: 20.r,
            decoration: BoxDecoration(
              color: type.color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Flexible(
            child: Text(
              type.label,
              style: AppTextStyle.commonText.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget leftIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            height: 20.r,
            width: 20.r,
            decoration: BoxDecoration(
              color: Colors.lime,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Flexible(
            child: Text(
              'Còn lại',
              style: AppTextStyle.commonText.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
