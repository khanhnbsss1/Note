import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note/pages/history_transaction/controller/history_transaction_controller.dart';

import '../../../config/app_color.dart';
import '../../../generated/l10n.dart';
import '../../../style/styles.dart';
import '../../expense/model/expenseType.dart';
import '../../expense/model/incomeType.dart';
import '../../expense/model/transaction_type.dart';

class BuildPieChart extends StatefulWidget {
  const BuildPieChart({super.key});

  @override
  State<BuildPieChart> createState() => _BuildPieChartState();
}

class _BuildPieChartState extends State<BuildPieChart> {
  final controller = Get.find<HistoryTransactionController>();
  int touchedIndex = -1;
  double smallestPercentToShowOnChart = 0.1;
  /// xây dựng pie chart bao gồm các section và chú thích bên cạnh
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
          ),
          height: 200.h,
          width: 220.w,
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
                sections: (controller.timeChart.value == TimeChart.day && controller.isExpense.value)
                    ? generatePieChartSections(ExpenseType.values)
                    : (controller.timeChart.value == TimeChart.day && !controller.isExpense.value)
                    ? generatePieChartSections(IncomeType.values)
                    : (controller.timeChart.value == TimeChart.month && controller.isExpense.value)
                    ? generatePieChartByMonthSections(ExpenseType.values)
                    : generatePieChartByMonthSections(IncomeType.values)
            ),
          ),
        ),),
        Obx(() => Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              changePieChartTypeRow(),
              ..._buildIndicators(),
              leftIndicator(),
            ],
          ),
        ),)
      ],
    );
  }


  /// xây dựng các chú thích của pie chart
  List<Widget> _buildIndicators() {
    final List<TransactionCategory> types =
    controller.isExpense.value ? ExpenseType.values : IncomeType.values;

    return types
        .where(
            (e) => controller.getPercentage(e) > smallestPercentToShowOnChart)
        .map((e) => indicator(e))
        .toList();
  }

  /// xây dựng các section của pie chart
  List<PieChartSectionData>
  generatePieChartSections<T extends TransactionCategory>(
      List<T> values,
      ) {
    int index = -1;
    double percentLeft = 1;
    Color defaultColor = Colors.lime;
    List<PieChartSectionData?> sections = values.map((item) {
      double percent = controller.getPercentage(item);
      double percent1 = controller.getPercentageByMonth(item, controller.spendingThisMonth);
      if (percent > smallestPercentToShowOnChart) {
        percentLeft -= percent;
        index++;
        return PieChartSectionData(
          showTitle: true,
          value: percent,
          color: item.color,
          title: '${(percent * 100).toStringAsFixed(0)}%',
          titleStyle: TextStyle(color: Colors.white),
          radius: (touchedIndex == index) ? 40 : 30,
        );
      }
      return null;
    }).toList();

    if (percentLeft > 0.01) {
      sections.add(PieChartSectionData(
        showTitle: true,
        value: percentLeft,
        color: defaultColor,
        title: '${(percentLeft * 100).toStringAsFixed(0)}%',
        titleStyle: TextStyle(color: Colors.white),
        radius: (touchedIndex == index) ? 40 : 30,
      ));
    }
    return sections.whereType<PieChartSectionData>().toList();
  }

  LineChartBarData get lineChartExpenseMonth => LineChartBarData(
    spots: controller.getTransactionByMonth(controller.expensesByDay).take(controller.count.value).map((e) {
      int totalIncome = e.totalExpense;
      return FlSpot(
          controller.getTransactionByMonth(controller.expensesByDay).indexOf(e).toDouble(),
          totalIncome.toDouble());
    }).toList(),
    isCurved: false,
    color: Colors.green,
    barWidth: 3,
    isStrokeCapRound: true,
    belowBarData: BarAreaData(
        show: true,
        color: Colors.green.withValues(alpha: 0.3)),
  );

  /// xây dựng 1 chú thích của pie chart
  Widget indicator<T extends TransactionCategory>(T type) {
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
              style: AppTextStyle.commonText.copyWith(
                  color: AppColor().textColor
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Chú thích còn lại của pie chart, được xây dựng khi phần còn lại chiếm hơn 0%
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
              S.current.remain,
              style: AppTextStyle.commonText.copyWith(
                  color: AppColor().textColor
              ),
            ),
          ),
        ],
      ),
    );
  }

  generatePieChartByMonthSections<T extends TransactionCategory>(
      List<T> values,
      ) {
    int index = -1;
    double percentLeft = 1;
    Color defaultColor = Colors.lime;
    List<PieChartSectionData?> sections = values.map((item) {
      double percent = controller.getPercentageByMonth(item, controller.spendingThisMonth);
      if (percent > smallestPercentToShowOnChart) {
        percentLeft -= percent;
        index++;
        return PieChartSectionData(
          showTitle: true,
          value: percent,
          color: item.color,
          title: '${(percent * 100).toStringAsFixed(0)}%',
          titleStyle: TextStyle(color: Colors.white),
          radius: (touchedIndex == index) ? 40 : 30,
        );
      }
      return null;
    }).toList();

    if (percentLeft > 0.01) {
      sections.add(PieChartSectionData(
        showTitle: true,
        value: percentLeft,
        color: defaultColor,
        title: '${(percentLeft * 100).toStringAsFixed(0)}%',
        titleStyle: TextStyle(color: Colors.white),
        radius: (touchedIndex == index) ? 40 : 30,
      ));
    }
    return sections.whereType<PieChartSectionData>().toList();
  }


  Widget changePieChartTypeRow() {
    return Obx(() => Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              controller.changeTimeChart(TimeChart.day);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: controller.timeChart.value == TimeChart.day ? AppColor().background : AppColor().textColor,
                ),
                color: controller.timeChart.value == TimeChart.day ? AppColor().textColor : AppColor().background,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 2.h),
                child: Text(
                  TimeChart.day.label,
                  style: AppTextStyle.commonText.copyWith(
                    color: controller.timeChart.value == TimeChart.day ? AppColor().background : AppColor().textColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          GestureDetector(
            onTap: (){
              controller.changeTimeChart(TimeChart.month);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: controller.timeChart.value == TimeChart.month ? AppColor().background : AppColor().textColor,
                ),
                color: controller.timeChart.value == TimeChart.month ? AppColor().textColor : AppColor().background,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 2.h),
                child: Text(
                  TimeChart.month.label,
                  style: AppTextStyle.commonText.copyWith(
                    color: controller.timeChart.value == TimeChart.month ? AppColor().background : AppColor().textColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
