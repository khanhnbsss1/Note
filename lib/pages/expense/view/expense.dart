import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/config/app_color.dart';
import 'package:note/style/styles.dart';

import 'transaction_tab.dart';

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
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: TabBar(
            onTap: (value) {
              setState(() {
                tabController.animateTo(value);
              });
            },
            controller: tabController,
            splashBorderRadius: BorderRadius.circular(10),
            // overlayColor: WidgetStatePropertyAll(AppColor.primary),
            // indicatorColor: Colors.red,
            dividerColor: Colors.transparent,
            enableFeedback: false,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: AppTextStyle.heading5.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: AppTextStyle.heading5.copyWith(
              fontSize: 14.sp,
            ),
            indicator: BoxDecoration(
                color: AppColor().textColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10)),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppColor().textColor
                ),
                child: Text(
                  'Chi tiêu',
                  style: AppTextStyle.commonText.copyWith(
                    color: AppColor().textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.account_balance,
                  color: AppColor().textColor,
                ),
                child: Text(
                  'Thu nhập',
                  style: AppTextStyle.commonText.copyWith(
                    color: AppColor().textColor,
                    fontWeight: FontWeight.bold,
                  ),
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
                TransactionTab(isExpense: true,),
                TransactionTab(isExpense: false,),
              ]),
        ),
      ],
    ));
  }
}
