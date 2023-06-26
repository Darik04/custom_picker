import 'package:camera/camera.dart';
import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/custom_picker/views/crop_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';



class CameraCard extends StatefulWidget {
  final Function(Uint8List photo) onPhoto;
  const CameraCard({super.key, required this.onPhoto});

  @override
  State<CameraCard> createState() => _CameraCardState();
}

class _CameraCardState extends State<CameraCard> {
  List<CameraDescription> _cameras = [];
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  initCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }


  void tapByCamera() async{
    controller = null;
    setState(() {});
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if(file != null){
      Uint8List bytesFile = await file.readAsBytes();
      widget.onPhoto(bytesFile);
    }
    initCamera();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapByCamera,
      child: Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.r),
              child: Container(
                color: ColorStyles.black2,
                width: 75.h,
                height: 75.h,
                child: controller == null
                ? null
                : CameraPreview(controller!),
              ),
            ),
            Positioned(
              top: 4.h,
              right: 4.41.w,
              child: SvgPicture.asset('assets/svg/camera_icon.svg')
            )
          ],
        ),
      ),
    );
  }
}