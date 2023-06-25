import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/custom_picker/custom_picker.dart';
import 'package:custom_picker/custom_picker/views/albums_view.dart';
import 'package:custom_picker/custom_picker/views/crop_view.dart';
import 'package:custom_picker/custom_picker/views/media_view.dart';
import 'package:custom_picker/custom_picker/widgets/modal_btn.dart';
import 'package:custom_picker/custom_picker/widgets/violet_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/camera_card.dart';

class CustomPickerWidget extends StatefulWidget {
  final Function(Uint8List photo) onPhotoChoosen;
  final Function() onCancel;
  final Function() onDelete;
  const CustomPickerWidget({
    Key? key,
    required this.onPhotoChoosen,
    required this.onCancel,
    required this.onDelete,
  }) : super(key: key);
  @override
  State<CustomPickerWidget> createState() => _CustomPickerWidgetState();
}

class _CustomPickerWidgetState extends State<CustomPickerWidget> {


  CustomPicker customPicker = CustomPicker();


  @override
  void initState() {
    super.initState();
    initRecent();
  }

  initRecent() async{
    if(customPicker.recentMediaFiles.isEmpty){
      await customPicker.getRecentMediaFiles();
      setState(() {});
    }
  }
  
  void _onCancel(){
    Navigator.pop(context);
    widget.onCancel();
  }

  void openGallery() async {
    Uint8List? cropped = await Navigator.push(context, CupertinoPageRoute(builder: (context) => AlbumsView(
      onCancel: _onCancel,
    )));
    if(cropped != null){
      widget.onPhotoChoosen(cropped);
      Navigator.pop(context);
    }
  }


  void tapByCamera() async{
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if(file != null){
      Uint8List bytesFile = await file.readAsBytes();
      // ignore: use_build_context_synchronously
      Uint8List? cropped = await Navigator.push(context, CupertinoPageRoute(builder: (context) 
        => CropperView(
          image: bytesFile, 
          onCancel: _onCancel,
        )));
      if(cropped != null){
        widget.onPhotoChoosen(cropped);
        Navigator.pop(context);
      }
    }
  }

  toCropView(Uint8List file) async{
    Uint8List? cropped = await Navigator.push(context, CupertinoPageRoute(builder: (context) 
      => CropperView(
        image: file, 
        onCancel: _onCancel,
      )));
    if(cropped != null){
      widget.onPhotoChoosen(cropped);
      Navigator.pop(context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: 285.h+MediaQuery.of(context).padding.bottom,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorStyles.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8.h, bottom: 7.h, left: 9.w),
                  height: 75.h,
                  child: ListView.builder(
                    itemCount: customPicker.recentMediaFilesUINT.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, idx) 
                      => idx == 0
                      ? CameraCard(
                        onTap: tapByCamera,
                      )
                      : GestureDetector(
                        onTap: () => toCropView(customPicker.recentMediaFilesUINT[idx - 1]),
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.r),
                            child: Image.memory(
                              customPicker.recentMediaFilesUINT[idx - 1],
                              width: 75.h,
                              height: 75.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                  ),
                ),

                ModalBtn(
                  onTap: openGallery,
                  text: 'Open gallery'
                ),
                Container(
                  width: double.infinity,
                  height: .75.h,
                  color: ColorStyles.white2,
                ),
                ModalBtn(
                  onTap: (){
                    Navigator.pop(context);
                    widget.onDelete();
                  }, 
                  text: 'Delete photo',
                  isEnd: true,
                )
              ],
            ),
          ),

          SizedBox(height: 10.5.h,),
          VioletBtn(
            onTap: _onCancel,
            text: 'Cancel',
          ),
        ],
      )
    );
  }





  
}
