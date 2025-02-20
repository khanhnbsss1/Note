import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/style/styles.dart';

import '../../controller/expense_controller.dart';

class IncomeTab extends StatefulWidget {
  const IncomeTab({super.key});

  @override
  State<IncomeTab> createState() => _IncomeTabState();
}

class _IncomeTabState extends State<IncomeTab> {
  TextEditingController moneyController = TextEditingController();
  ExpenseController controller = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: moneyController,
          style: AppTextStyle.commonText.copyWith(
            color: Colors.white,
          ),
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
                      controller.changeSelectedIncomeType(IncomeType.values[index]);
                    },
                    child: Obx(() => item(IncomeType.values[index])));
              },
              childCount: IncomeType.values.length,
            ),
            shrinkWrap: true,
          ),
        ),
        ElevatedButton(onPressed: () {
          controller.createTransaction(controller.selectedIncomeType.value, int.parse(moneyController.text));
        }, child: Text('Thêm')),
      ],
    );
  }

  Widget item(IncomeType type) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: (controller.selectedIncomeType.value == type) ? Colors.cyan : Colors.white,
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