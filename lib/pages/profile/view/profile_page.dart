import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note/config/app_color.dart';
import 'package:note/pages/profile/controller/profile_controller.dart';
import 'package:note/style/styles.dart';

import '../../../generated/l10n.dart';
import '../widget/item_setting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController controller = Get.find<ProfileController>();
  final GlobalKey _dropdownKey = GlobalKey();

  void _openDropdown() {
    final RenderBox? renderBox = _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      GestureBinding.instance.handlePointerEvent(
        PointerDownEvent(
          position: position + Offset(size.width / 2, size.height / 2),
        ),
      );
      GestureBinding.instance.handlePointerEvent(
        PointerUpEvent(
          position: position + Offset(size.width / 2, size.height / 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: CircleAvatar(
                minRadius: 60.r,
                child: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Center(child: Text(S.current.setting, style: AppTextStyle.commonText,)),
            SizedBox(
              height: 8.h,
            ),
            ItemSetting(
                text: S.current.language,
                onChanged: (_) {},
                icon: Icon(Icons.settings, color: AppColor().textColor,),
                initialValue: controller.languageCode.value == 'vi',
                trailing: buildLanguageTrailing(),
            ),
            SizedBox(
              height: 8.h,
            ),
            ItemSetting(
                text: S.current.night_mode,
                onChanged: (value) {
                  controller.saveSettings(value);
                },
                icon: Icon(Icons.settings, color: AppColor().textColor,),
                initialValue: controller.enDarkMode.value),
            SizedBox(
              height: 8.h,
            ),
            ItemSetting(
              text: S.current.Time_check_transaction,
              onChanged: (_) {
                _openDropdown();
              },
              icon: Icon(Icons.settings, color: AppColor().textColor),
              initialValue: controller.enDarkMode.value,
              trailing: Obx(() => DropdownButton<int>(
                    key: _dropdownKey,
                    value: controller.monthTime.value,
                    dropdownColor: AppColor().background,
                    focusColor: AppColor().textColor,
                    items: [1, 3, 6, 12].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          value.toString(),
                          style: AppTextStyle.commonText.copyWith(
                            color: AppColor().textColor,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      if (value != null) {
                        controller.saveMonthTime(value);
                      }
                    },
                  )),
            ),
            SizedBox(
              height: 8.h,
            ),
            ItemSetting(
                text: S.current.setting,
                onChanged: (_) {},
                icon: Icon(Icons.settings, color: AppColor().textColor,),
                initialValue: controller.enDarkMode.value),
            SizedBox(
              height: 8.h,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${S.current.version} ${controller.sharedPreferencesIml.version}', style: AppTextStyle.commonText.copyWith(
                  color: AppColor().textColor,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageTrailing() {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          curve: Curves.easeInOutCubic,
          child: Opacity(
            opacity: controller.languageCode.value == 'vi' ? 1 : 0.5,
            child: GestureDetector(
              onTap: () {
                controller.saveLanguage('vi');
              },
              child: Icon(Icons.flag, color: AppColor().textColor,),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          curve: Curves.easeInOutCubic,
          child: Opacity(
            opacity: controller.languageCode.value == 'en' ? 1 : 0.5,
            child: GestureDetector(
              onTap: () {
                controller.saveLanguage('en');
              },
              child: Icon(Icons.flag_circle, color: AppColor().textColor,),
            ),
          ),
        ),
      ],
    );
  }
}
