import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note/pages/history_transaction/controller/history_transaction_controller.dart';

import '../../../config/app_color.dart';
import '../../../config/app_config.dart';
import '../../../style/styles.dart';
import '../../../util/date_utils.dart';
import '../model/transaction.dart';

class BuildLineChart extends StatefulWidget {
  const BuildLineChart({super.key});

  @override
  State<BuildLineChart> createState() => _BuildLineChartState();
}

class _BuildLineChartState extends State<BuildLineChart> {
  final controller = Get.find<HistoryTransactionController>();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white.withValues(alpha: 0.2),
        ),
        height: 200.h,
        padding:
        EdgeInsets.only(left: 20.w, right: 40.w, top: 16.h, bottom: 16.h),
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
                  interval: controller.getIntervalForLineChart(),
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${(value ~/ 1000)}K',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColor().textColor.withValues(alpha: 0.6)),
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
                    List<TransactionByDay> list = (controller.isExpense.value)
                        ? controller.expensesByDay
                        : controller.incomeByDay;
                    if (index >= 0 && index < list.length && index < 7) {
                      return Text(
                        DateUtilsFormat.toDateTimeString(list[index].date!,
                            format: AppConfigs.dateTimeDisplayFormat3),
                        style: AppTextStyle.commonText.copyWith(
                            color: AppColor().textColor.withValues(alpha: 0.6),
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
                spots: controller.expensesByDay.take(controller.count.value).map((e) {
                  int totalExpense = e.totalExpense;
                  return FlSpot(
                      controller.expensesByDay.indexOf(e).toDouble(),
                      totalExpense.toDouble());
                }).toList(),
                isCurved: false,
                color: Colors.red,
                barWidth: 3,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                    show: true, color: Colors.red.withValues(alpha: 0.3)),
              )
                  :

              // Income Line (Green)
              LineChartBarData(
                spots: controller.incomeByDay.take(controller.count.value).map((e) {
                  int totalIncome = e.totalIncome;
                  return FlSpot(
                      controller.incomeByDay.indexOf(e).toDouble(),
                      totalIncome.toDouble());
                }).toList(),
                isCurved: false,
                color: Colors.green,
                barWidth: 3,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                    show: true,
                    color: Colors.green.withValues(alpha: 0.3)),
              ),
            ],
          ),
        ));
  }
}
