import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/pages/add_edit_node/controller/add_edit_node_controller.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../../config/app_config.dart';
import '../../../../style/styles.dart';
import '../../../../util/date_utils.dart';
import '../../../model/list_note.dart';
import 'package:get/get.dart';

class AddEditNote extends GetWidget<AddEditNodeController> {
  const AddEditNote({super.key, this.note});

  final NoteDetail? note;

  PreferredSizeWidget? appBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      title: Text('Edit'),
      centerTitle: true,
      automaticallyImplyLeading: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.onInitNote(note);
    return Scaffold(
      appBar: appBar(),
      body: Hero(
        tag: note?.title ?? UniqueKey(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRowData(
              title: 'Title',
              hintText: 'Enter your title',
              controller: controller.titleController.value,
            ),
            Divider(
              indent: 16.w,
              endIndent: 16.w,
              thickness: 1,
              color: Colors.grey.withValues(alpha: 0.2),
            ),
            buildRowData(
              title: 'Date',
              hintText: 'Pick your date',
              controller: controller.dateController.value,
              readOnly: true,
              suffixIcon: Icon(
                Icons.calendar_month,
                color: Colors.teal,
              ),
              onTap: () {
                pickDate(context).then((value) {
                  controller.dateController.value.text = value ?? "";
                });
              },
            ),
            Divider(
              indent: 16.w,
              endIndent: 16.w,
              thickness: 1,
              color: Colors.grey.withValues(alpha: 0.2),
            ),
            Expanded(
              child: buildRowData(
                title: 'Content',
                hintText: 'Enter your content',
                controller: controller.contentController.value,
                maxLine: 10,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingButton(context)
    );
  }

  Widget floatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.teal,
      onPressed: () {
        Get.back(
          result: NoteDetail(
            title: controller.titleController.value.text,
            content: controller.contentController.value.text.trim(),
            time: DateUtilsFormat.fromString(controller.dateController.value.text,
                format: AppConfigs.dateTimeDisplayFormat1),
          ),
        );
      },
      child: Icon(Icons.check_sharp),
    );
  }

  Widget buildRowData({
    required String title,
    required String hintText,
    required TextEditingController controller,
    int? maxLine,
    TextStyle? titleStyle,
    TextStyle? hintStyle,
    bool? readOnly,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTextStyle.heading5,
            ),
            TextFormField(
              onTap: onTap,
              controller: controller,
              style: AppTextStyle.commonText,
              maxLines: maxLine ?? 1,
              readOnly: readOnly ?? false,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusColor: Colors.transparent,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.all(8.sp),
                hintText: hintText,
                suffixIcon: suffixIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> pickDate(BuildContext context) async {
    DateTime? date = await showOmniDateTimePicker(
      context: context,
      initialDate: note?.time ?? DateTime.now(),
      firstDate: DateTime.now().add(Duration(days: -90)),
      lastDate: DateTime.now().add(Duration(days: 90)),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      type: OmniDateTimePickerType.dateAndTime,
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
    );
    return DateUtilsFormat.toDateAPIString(date ?? DateTime.now(),
        format: AppConfigs.dateTimeDisplayFormat1);
  }
}
