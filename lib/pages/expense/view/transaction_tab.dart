import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note/config/app_color.dart';
import 'package:note/pages/expense/model/expenseType.dart';
import 'package:note/pages/expense/model/incomeType.dart';
import 'package:note/style/styles.dart';

import '../controller/expense_controller.dart';

class TransactionTab extends StatefulWidget {
  final bool isExpense;
  const TransactionTab({super.key, required this.isExpense});

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  TextEditingController moneyController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  ExpenseController controller = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              buildTextField(),
              SizedBox(height: 12.h),
              buildContent(),
              // ElevatedButton(
              //   onPressed: () {
              //     if (widget.isExpense) {
              //       controller.createTransaction<ExpenseType>(
              //           controller.selectedExpenseType.value,
              //           int.parse(moneyController.text),
              //           noteController.text,
              //       );
              //     } else {
              //       controller.createTransaction<IncomeType>(
              //           controller.selectedIncomeType.value,
              //           int.parse(moneyController.text),
              //           noteController.text,
              //       );
              //     }
              //   },
              //   child: Text('Thêm'),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: buildButton(),
    );
  }

  Widget buildTextField() {
    return Form(
      key: (widget.isExpense) ? controller.formKeyExpense : controller.formKeyIncome,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: moneyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    labelStyle: AppTextStyle.commonText.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                    prefixIcon: Icon(Icons.attach_money, color: AppColor().primaryLight),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: AppColor().primaryLight, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: AppColor().primaryDark, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
                    ),
                  ),
                  style: AppTextStyle.commonText.copyWith(fontSize: 18.sp),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng điền số tiền';
                    }
                    if (int.tryParse(value)! < 1000) {
                      return 'Số tiền phải lớn hơn 1000';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: noteController,
                  decoration: InputDecoration(
                    labelText: 'Enter note',
                    labelStyle: AppTextStyle.commonText.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                    prefixIcon: Icon(Icons.attach_money, color: AppColor().primaryLight),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: AppColor().primaryLight, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: AppColor().primaryDark, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
                    ),
                  ),
                  style: AppTextStyle.commonText.copyWith(fontSize: 18.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent() {
    return GridView.custom(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
          return GestureDetector(
            onTap: () {
              if (widget.isExpense) {
                controller.changeSelectedType(ExpenseType.values[index]);
              } else {
                controller.changeSelectedType(IncomeType.values[index]);
              }
            },
            child: Obx(() => buildItem(
                widget.isExpense ? ExpenseType.values[index] : IncomeType.values[index])),
          );
        },
        childCount:
        widget.isExpense ? ExpenseType.values.length : IncomeType.values.length,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget buildItem(dynamic type) {
    bool isSelected = widget.isExpense
        ? controller.selectedExpenseType.value == type
        : controller.selectedIncomeType.value == type;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColor().primaryLight : Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(type.icon),
          SizedBox(height: 4.h),
          Text(
            type.label,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyle.commonText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton() {
    return FloatingActionButton(
      backgroundColor: AppColor().primaryDark,
      onPressed: () {
        controller.submitForm(
            isExpense: widget.isExpense,
            money: moneyController.text,
            note: noteController.text);
      },
      child: Icon(Icons.add),
    );
  }
}
