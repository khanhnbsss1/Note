import 'package:flutter/cupertino.dart';
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
                onChanged: (_) {
                  controller.saveLanguage(_);
                },
                icon: Icon(Icons.settings, color: AppColor().textColor,),
                initialValue: controller.isLanguage.value == 1),
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
                text: S.current.setting,
                onChanged: (_) {},
                icon: Icon(Icons.settings, color: AppColor().textColor,),
                initialValue: controller.enDarkMode.value),
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
}

