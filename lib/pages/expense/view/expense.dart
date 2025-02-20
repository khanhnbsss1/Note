import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:note/config/app_config.dart';
import 'package:note/pages/calendar/controller/calender_controller.dart';
import 'package:note/pages/expense/controller/expense_controller.dart';
import 'package:note/pages/expense/widgets/expense_tab/expense_tab.dart';
import 'package:note/pages/expense/widgets/income_tab/income_tab.dart';
import 'package:note/style/styles.dart';
import 'package:note/util/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage>
    with TickerProviderStateMixin {
  late TabController tabController;

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
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
              child: TabBar(
                onTap: (value) {
                  tabController.animateTo(value);
                },
                controller: tabController,
                indicatorColor: Colors.white,
                dividerColor: Colors.transparent,
                enableFeedback: false,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: AppTextStyle.heading5.copyWith(
                  fontSize: 14.sp, // Style for the selected tab
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: AppTextStyle.heading5.copyWith(
                  fontSize: 14.sp, // Style for unselected tabs
                ),
                indicator: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    child: Text(
                      'Chi tiêu',
                      style:
                          AppTextStyle.commonText.copyWith(color: Colors.white),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.account_balance,
                      color: Colors.white,
                    ),
                    child: Text(
                      'Thu nhập',
                      style:
                          AppTextStyle.commonText.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    ExpenseTab(),
                    IncomeTab(),
                  ]),
            ),
          ],
        ));
  }
}
