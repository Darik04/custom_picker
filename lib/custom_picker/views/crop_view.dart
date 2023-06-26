import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/constants/texts/text_styles.dart';
import 'package:custom_picker/custom_picker/cropper.dart';
import 'package:custom_picker/custom_picker/widgets/modals/cancel_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class CropperView extends StatefulWidget {
  final Uint8List image;
  final Function() onCancel;

  const CropperView({Key? key, required this.image, required this.onCancel}) : super(key: key);

  @override
  State<CropperView> createState() => _CropperViewState();
}

class _CropperViewState extends State<CropperView> {
  final GlobalKey _cropperKey = GlobalKey(debugLabel: 'cropperKey');
  Uint8List? _imageToCrop;
  bool isReset = false;

  @override
  void initState() {
    super.initState();
    _imageToCrop = widget.image;
  }


  void _cancel(){
    cancelModal(
      context, 
      cancelChanges: (){
        Navigator.pop(context);
        widget.onCancel();
      }, 
      cancel: (){
        // setState(() {
        //   _imageToCrop = null;
        // });
        // Future.delayed(Duration(milliseconds: 1200), (){
        //   setState(() {
        //     _imageToCrop = widget.image;
        //   });
        // });
      }
    );
  }


  void _accept() async {
   final imageBytes = await Cropper.crop(
      cropperKey: _cropperKey,
    );

    if (imageBytes != null) {
      Navigator.pop(context, imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: ColorStyles.black2,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _imageToCrop == null
            ? Center(
              child: CircularProgressIndicator(),
            )
            : Cropper(
              aspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height,
              cropperKey: _cropperKey,
              overlayType: OverlayType.circle,
              backgroundColor: ColorStyles.black2,
              overlayColor: ColorStyles.black2.withOpacity(0.5),
              zoomScale: 2,
              image: Image.memory(_imageToCrop!),
            )
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: ColorStyles.white,
                height: 48.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _cancel,
                      behavior: HitTestBehavior.opaque,
                      child: SvgPicture.asset('assets/svg/cancel_icon.svg', height: 34.h,)
                    ),
                    GestureDetector(
                      onTap: _accept,
                      behavior: HitTestBehavior.opaque,
                      child: SvgPicture.asset('assets/svg/accept_icon.svg', height: 34.h,)
                    ),
                  ],
                ),
              )
            )

        ],
      ),
    );
  }
}

