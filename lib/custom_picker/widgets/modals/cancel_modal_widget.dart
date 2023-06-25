import 'package:custom_picker/custom_picker/widgets/violet_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelModalWidget extends StatelessWidget {
  final Function() cancelChanges;
  final Function() cancel;
  CancelModalWidget({required this.cancel, required this.cancelChanges});

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      height: 140.h,
      child: Column(
        children: [
          VioletBtn(
            onTap: (){
              Navigator.pop(context);
              cancelChanges();
            }, 
            text: 'Cancel Changes',
          ),

          SizedBox(height: 10.5.h,),
          VioletBtn(
            onTap: (){
              Navigator.pop(context);
              cancel();
            }, 
            text: 'Cancel',
          ),
        ],
      )
    );
  }





  
}
