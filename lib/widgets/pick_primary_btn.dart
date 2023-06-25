import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/constants/texts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PickPrimaryBtn extends StatelessWidget {
  final Function() onTap;
  const PickPrimaryBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(
          color: ColorStyles.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: Text('Pick Photo', style: TextStyles(context).btn_white),
      ),
    );
  }
}