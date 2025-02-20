import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:note/config/app_config.dart';
import 'package:note/pages/calendar/controller/calender_controller.dart';
import 'package:note/pages/expense/model/expenseType.dart';
import 'package:note/style/styles.dart';
import 'package:note/util/date_utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/expense_controller.dart';

class ExpenseTab extends StatefulWidget {
  const ExpenseTab({super.key});

  @override
  State<ExpenseTab> createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> {
  TextEditingController moneyController = TextEditingController();
  ExpenseController controller = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: moneyController,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            child: GridView.custom(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              childrenDelegate: SliverChildBuilderDelegate(
                (builder, index) {
                  return GestureDetector(
                      onTap: () {
                        controller
                            .changeSelectedExpenseType(ExpenseType.values[index]);
                      },
                      child: Obx(() => item(ExpenseType.values[index])));
                },
                childCount: ExpenseType.values.length,
              ),
              shrinkWrap: true,
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Thêm')),
        ],
      ),
    );
  }

  Widget item(ExpenseType type) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: (controller.selectedExpenseType.value == type)
            ? Colors.cyan
            : Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            type.icon,
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            type.label,
            style: AppTextStyle.commonText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
