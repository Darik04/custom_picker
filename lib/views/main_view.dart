import 'package:custom_picker/constants/texts/text_styles.dart';
import 'package:custom_picker/custom_picker/main.dart';
import 'package:custom_picker/widgets/pick_primary_btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


enum ScreenState{
  none,
  cancel,
  deleted,
  photoChoosen
}


  //EXAMPLE VIEW
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {


  List<Uint8List> listMedia = [];
  ScreenState currentState = ScreenState.none;

  onPick(BuildContext context){
    customPicker(
      context,
      onPhotoChoosen: (photo){
        print('photo choosen');
        setState(() {
          currentState = ScreenState.photoChoosen;
          listMedia.add(photo);
        });
      },
      onCancel: (){
        print('cancel');
        setState(() {
          currentState = ScreenState.cancel;
        });
      },
      onDelete: (){
        print('delete');
        setState(() {
          currentState = ScreenState.deleted;
        });
      }
    );
  }


  //EXAMPLE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              children: [
                SizedBox(height: 52.h,),
                Text('Choose Photo', style: TextStyles(context).headline1,),
                SizedBox(height: 62.h,),
                PickPrimaryBtn(
                  onTap: () => onPick(context)
                ),
                SizedBox(height: 116.h,),
                Text(
                  currentState == ScreenState.cancel
                  ? 'cancelled'
                  : currentState == ScreenState.deleted
                  ? 'delete photo'
                  : currentState == ScreenState.photoChoosen
                  ? '${listMedia.length} photo chosen'
                  : '', 
                  style: TextStyles(context).headline1,
                ),
                // SizedBox(height: 62.h,),
                // if(listMedia.isNotEmpty)
                // Image.memory(
                //   listMedia.last,
                //   width: 300.w,
                //   height: 300.w,
                //   fit: BoxFit.cover,
                // ),
                // SizedBox(height: 62.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}