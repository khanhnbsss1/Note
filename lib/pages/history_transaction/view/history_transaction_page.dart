import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note/config/app_config.dart';
import 'package:note/pages/expense/model/expenseType.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/pages/expense/model/transaction_type.dart';
import 'package:note/pages/history_transaction/model/transaction.dart';
import 'package:note/pages/history_transaction/widget/pie_chart.dart';
import 'package:note/style/styles.dart';
import 'package:note/util/date_utils.dart';
import 'package:note/util/string_format.dart';

import '../../../config/app_color.dart';
import '../../../generated/l10n.dart';
import '../controller/history_transaction_controller.dart';
import '../widget/line_chart.dart';

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
    return SafeArea(
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFunctionBar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Obx(
                  () => (controller.isLineChart.value)
                  ? BuildLineChart()
                  : BuildPieChart(),
            ),
          ),
          Obx(
                () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                  (controller.isExpense.value)
                      ? '${S.current.total_expense} : ${StringFormatter.formatNumber(controller.getTotalExpenseForMonth(DateTime.now()))} VND'
                      : '${S.current.total_income} : ${StringFormatter.formatNumber(controller.getTotalIncomeForMonth(DateTime.now()))} VND',
                  style: AppTextStyle.heading5.copyWith(
                      color: controller.isExpense.value
                          ? AppColor().accentPink
                          : AppColor().accentGreen)),
            ),
          ),
          Flexible(
            child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  // expenseTab(),
                  // incomeTab(),
                  detailTab(controller.expensesByDay),
                  detailTab(controller.incomeByDay),
                ]),
          ),
        ],
      ),
    );
  }

  Widget buildFunctionBar() {
    return Obx(
          () => Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
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
              ),
              color: AppColor().iconColor,
            ),
            IconButton(
              onPressed: () {
                controller.showExpenseStatic();
                setState(() {
                  tabController.animateTo(controller.isExpense.value ? 0 : 1);
                });
              },
              icon: Icon(
                controller.isExpense.value
                    ? Icons.shopping_cart
                    : Icons.account_balance,
              ),
              color: AppColor().iconColor,
            ),
            DropdownMenu<TimeChart>(
              initialSelection: controller.timeChart.value,
              trailingIcon: Icon(
                Icons.arrow_drop_down,
                color: AppColor().textColor,
              ),
              selectedTrailingIcon: Icon(
                Icons.arrow_drop_up,
                color: AppColor().textColor,
              ),
              dropdownMenuEntries: TimeChart.values
                  .map(
                    (e) =>
                        DropdownMenuEntry<TimeChart>(
                      value: e,
                      label: e.label,
                      labelWidget: Text(
                        e.label,
                        style: AppTextStyle.commonText.copyWith(
                          color: AppColor().textColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).scaffoldBackgroundColor),
              ),
              onSelected: (value) {
                if (value != null) {
                  controller.changeTimeChart(value);
                }
              },
              label: Text(
                S.current.ordered_by,
                style: AppTextStyle.heading5.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColor().textColor,
                ),
              ),
              textStyle: AppTextStyle.heading5.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColor().textColor,
              ),
            ),
            SizedBox(
              width: 12.w,
            )
          ],
        ),
      ),
    );
  }

  Widget detailTab(List<TransactionByDay> list) {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index1) {
        return Theme(
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
                  return item(list[index1].transactions![index2]);
                },
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 0.h,
        );
      },
      itemCount: controller.expensesByDay.length,
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
                color: AppColor().iconColor,
            ),
          ),
          Text(
            DateUtilsFormat.dayOfWeekFormat(date.weekday),
            style: AppTextStyle.commonText.copyWith(
                color: AppColor().iconColor,
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
          height: 60.h,
        ),
      ),
      title: Text(
        transaction.type!.label,
        style: AppTextStyle.commonText.copyWith(
            color: AppColor().textColor
        ),
      ),
      subtitle: (transaction.note != '' && transaction.note != null)
          ? Text(
              transaction.note ?? "",
              style: AppTextStyle.commonText
                  .copyWith(fontSize: 12.sp, color: AppColor().textColor),
            )
          : null,
      trailing: Text(
        '${!transaction.isExpense ? StringFormatter.formatNumber(transaction.amount) : '-${StringFormatter.formatNumber(transaction.amount)}'} đ',
        style: AppTextStyle.commonText.copyWith(color: AppColor().textColor),
      ),
    );
  }
}
