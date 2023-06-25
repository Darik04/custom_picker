import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/constants/texts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomBar extends StatelessWidget {
  const CustomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 81.h+MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: ColorStyles.white,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: Text('Recent', style: TextStyles(context).headline2,)),
          Positioned(
            left: 8.w,
            bottom: 33.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/chevron_back.svg', height: 16.h,),
                SizedBox(width: 8.w,),
                Text('Albums', style: TextStyles(context).primary_14_w500,)
              ],
            )
          )
        ],
      ),
    );
  }
}