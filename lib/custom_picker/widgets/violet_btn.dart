import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/constants/texts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class VioletBtn extends StatelessWidget {
  final Function() onTap;
  final String text;
  const VioletBtn({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: ColorStyles.white,
          borderRadius: BorderRadius.circular(10.r)
        ),
        alignment: Alignment.center,
        child: Text(text, style: TextStyles(context).violet_14_w500),
      ),
    );
  }
}