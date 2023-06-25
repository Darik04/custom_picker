import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/constants/texts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ModalBtn extends StatelessWidget {
  final Function() onTap;
  final bool isEnd; 
  final String text;
  final Color? customColorText;
  const ModalBtn({super.key, required this.onTap, this.isEnd = false, required this.text, this.customColorText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: ColorStyles.white,
          borderRadius: !isEnd 
          ? null 
          : BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          )
        ),
        alignment: Alignment.center,
        child: Text(text, style: TextStyles(context).primary_14_w500.copyWith(color: customColorText)),
      ),
    );
  }
}