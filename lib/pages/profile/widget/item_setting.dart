import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/app_color.dart';
import '../../../style/styles.dart';

class ItemSetting extends StatefulWidget {
  const ItemSetting({
    super.key,
    required this.text,
    required this.onChanged,
    this.icon,
    this.initialValue,
    this.trailing,
    this.page,
    this.textStyle,
  });

  final String text;
  final Function(bool) onChanged;
  final Widget? icon;
  final bool? initialValue;
  final Widget? trailing;
  final String? page;
  final TextStyle? textStyle;

  @override
  State<ItemSetting> createState() => _ItemSettingState();
}

class _ItemSettingState extends State<ItemSetting> {
  late bool _enable;

  @override
  void initState() {
    _enable = widget.initialValue ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _enable = !_enable;
        });
        widget.onChanged(_enable);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor().textColor
          ),
          borderRadius: BorderRadius.circular(16.r),
          color: AppColor().background
        ),
        child: Row(
          children: [
            if (widget.icon != null)
              Row(
                children: [
                  widget.icon!,
                  SizedBox(
                    width: 8.w,
                  )
                ],
              ),
            Expanded(
              child: Text(
                widget.text,
                style: widget.textStyle ?? AppTextStyle.commonText.copyWith(
                  color: AppColor().textColor,
                ),
              ),
            ),
            (widget.trailing != null)
                ? widget.trailing!
                : CupertinoSwitch(
                    value: _enable,
                    onChanged: (value) {
                      setState(() {
                        _enable = !_enable;
                      });
                      widget.onChanged(_enable);
                    }),
          ],
        ),
      ),
    );
  }
}
