import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/main_config_app.dart';
import '../colors/color_styles.dart';

class TextStyles {

  final BuildContext context;
  TextStyles(this.context) : super(){
    ScreenUtil.init(
      context,
      designSize: MainConfigApp.screenSize
    );
  }

  // BY MODULES
  TextStyle headline1 = TextStyle(
      fontFamily: MainConfigApp.fontFamily1,
      fontStyle: FontStyle.normal,
      fontSize: 30.sp,
      fontWeight: FontWeight.w600,
      color: ColorStyles.black);
  TextStyle headline2 = TextStyle(
      fontFamily: MainConfigApp.fontFamily1,
      fontStyle: FontStyle.normal,
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: ColorStyles.black);
  TextStyle btn_white = TextStyle(
      fontFamily: MainConfigApp.fontFamily1,
      fontStyle: FontStyle.normal,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFEBEBEB));


  // black
  TextStyle black_20_w700 = TextStyle(
      fontFamily: MainConfigApp.fontFamily1,
      fontStyle: FontStyle.normal,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: ColorStyles.black);

  
  


  // primary
  TextStyle primary_14_w500 = TextStyle(
      fontFamily: MainConfigApp.fontFamily1,
      fontStyle: FontStyle.normal,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorStyles.primary);
  


  // violet
  TextStyle violet_14_w500 = TextStyle(
      fontFamily: MainConfigApp.fontFamily1,
      fontStyle: FontStyle.normal,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorStyles.violet);

  

  // white
  TextStyle white_14_w500 = TextStyle(
      fontFamily: MainConfigApp.fontFamily1,
      fontStyle: FontStyle.normal,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: ColorStyles.white2);

      
}