import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note/config/app_color.dart';
import 'package:note/pages/profile/controller/profile_controller.dart';
import 'package:note/style/styles.dart';

import '../widget/item_setting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController controller = Get.find<ProfileController>();

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
            Center(child: Text('Xin chào ', style: AppTextStyle.commonText,)),
            SizedBox(
              height: 8.h,
            ),
            ItemSetting(
                text: 'Ngôn ngữ',
                onChanged: (_) {},
                icon: Icon(Icons.settings, color: AppColor().textColor,),
                initialValue: controller.enDarkMode.value),
            SizedBox(
              height: 8.h,
            ),
            ItemSetting(
                text: 'Chế độ ban đêm',
                onChanged: (value) {
                  controller.saveSettings(value);
                },
                icon: Icon(Icons.settings, color: AppColor().textColor,),
                initialValue: controller.enDarkMode.value),
            SizedBox(
              height: 8.h,
            ),
            ItemSetting(
                text: 'Cài đặt',
                onChanged: (_) {},
                icon: Icon(Icons.settings, color: AppColor().textColor,),
                initialValue: controller.enDarkMode.value),
            SizedBox(
              height: 8.h,
            ),
            ItemSetting(
                text: 'Cài đặt',
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
                Text('Phiên bản 1.0.0', style: AppTextStyle.commonText.copyWith(
                  color: AppColor().textColor,
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

