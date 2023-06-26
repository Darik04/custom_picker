import 'package:camera/camera.dart';
import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/custom_picker/views/crop_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';



class ImageCard extends StatefulWidget {
  final Function(Uint8List photo) onTap;
  final AssetEntity file;
  const ImageCard({super.key, required this.onTap, required this.file});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  Uint8List? file;
  bool startAnimate = false;

  @override
  void initState() {
    super.initState();
    initFile();
  }
  initFile() async {
    Future.delayed(Duration(milliseconds: 100), ()async{
      startAnimate = true;
      setState(() {});
    });
    Future.delayed(Duration(milliseconds: 400), ()async{
      file = await widget.file.thumbnailDataWithSize(ThumbnailSize(300, 300));
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(file!);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        color: !startAnimate ? ColorStyles.white2 : ColorStyles.black,
        width: 120.w,
        height: 120.w,
        child: file == null
        ? null
        : Image.memory(
          file!,
          width: 120.w,
          height: 120.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}