import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'cancel_modal_widget.dart';

cancelModal(
  BuildContext context, 
  {
    required Function() cancelChanges,
    required Function() cancel,
  }
) {
  showMaterialModalBottomSheet(
    animationCurve: Curves.easeInOutQuint,
      elevation: 0,
      barrierColor: ColorStyles.black2.withOpacity(0.35),
      duration: const Duration(milliseconds: 600),
      backgroundColor: Colors.transparent,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(15.r),
      //   ),
      // ),
      enableDrag: false,
      context: context,
      builder: (context) {
        return CancelModalWidget(
          cancel: cancel,
          cancelChanges: cancelChanges,
        );
      });
}

