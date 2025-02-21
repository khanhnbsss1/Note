import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note/config/app_config.dart';
import 'package:note/pages/expense/model/expenseType.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/pages/expense/model/transaction_type.dart';
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
                      )),
                  DropdownMenu<TimeChart>(
                    initialSelection: controller.timeChart.value,
                    dropdownMenuEntries: TimeChart.values
                        .map((e) => DropdownMenuEntry<TimeChart>(
                        value: e, label: e.label),)
                        .toList(),
                    onSelected: (value) {
                      if (value != null) {
                        controller.timeChart.value = value;
                      }
                    },
                    label: Text(
                      'Ordered by ',
                      style: AppTextStyle.heading5.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    textStyle: AppTextStyle.heading5.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12.w,)
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Obx(
              () => (controller.isLineChart.value) ? buildLineChart() : buildPieChart(),
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
                  // expenseTab(),
                  // incomeTab(),
                  detailTab(controller.dummyExpensesByDay),
                  detailTab(controller.dummyIncomeByDay),
                ]),
          ),
        ],
      ),
    );
  }

  Widget detailTab(List<TransactionByDay> list) {
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
                title: dayTile(list[index1].date!),
                showTrailingIcon: false,
                initiallyExpanded: true,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list[index1].transactions!.length,
                    itemBuilder: (context, index2) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 12.h),
                        child: item(list[index1].transactions![index2]),
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

  Widget item(Transaction transaction) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          transaction.type!.icon,
          height: 100.h,
        ),
      ),
      title: Text(
        transaction.type!.label,
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
        '${!transaction.isExpense ? StringFormatter.formatNumber(transaction.amount) : '-${StringFormatter.formatNumber(transaction.amount)}'} đ',
        style: AppTextStyle.commonText.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  /// xâu dựng line chart
  Widget buildLineChart() {
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
                  interval: (controller.isExpense.value) ? 100000 : 1000000,
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
                    List<TransactionByDay> list = (controller.isExpense.value) ? controller.dummyExpensesByDay : controller.dummyIncomeByDay;
                    if (index >= 0 &&
                        index < list.length) {
                      return Text(
                        DateUtilsFormat.toDateTimeString(
                            list[index].date!,
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
                          show: true, color: Colors.red.withValues(alpha: 0.3)),
                    )
                  :

                  // Income Line (Green)
                  LineChartBarData(
                      spots: controller.dummyIncomeByDay.map((e) {
                        int totalIncome = e.totalIncome;
                        return FlSpot(
                            controller.dummyIncomeByDay.indexOf(e).toDouble(),
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

  int touchedIndex = -1;

  /// xây dựng pie chart bao gồm các section và chú thích bên cạnh
  Widget buildPieChart() {
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
              sections: controller.isExpense.value
                  ? generatePieChartSections(
                      ExpenseType.values,
                    )
                  : generatePieChartSections(
                      IncomeType.values,
                    ),
            ),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildIndicators(),
              leftIndicator(),
            ],
          ),
        ),
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
              style: AppTextStyle.commonText.copyWith(color: Colors.white),
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
              'Còn lại',
              style: AppTextStyle.commonText.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
