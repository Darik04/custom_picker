import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/constants/texts/text_styles.dart';
import 'package:custom_picker/custom_picker/custom_picker.dart';
import 'package:custom_picker/custom_picker/helpers/truncate_text_helper.dart';
import 'package:custom_picker/custom_picker/views/albums_view.dart';
import 'package:custom_picker/custom_picker/widgets/image_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_manager/photo_manager.dart';

import 'crop_view.dart';



class MediaView extends StatefulWidget {
  final AssetPathEntity album;
  final Function() onCancel;
  final bool isFromMain;
  MediaView({super.key, required this.album, required this.onCancel, this.isFromMain = false});

  @override
  State<MediaView> createState() => _MediaViewState();
}

class _MediaViewState extends State<MediaView> {


  CustomPicker customPicker = CustomPicker();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initMedia();
  }

  initMedia() async {
    customPicker.resetPagination();
    await customPicker.getCurrentMediaFiles(widget.album);
    setState(() {});
    paginationOnScrolling();
  }

  paginationOnScrolling() async {
    _scrollController.addListener(() async {
      if ((_scrollController.position.maxScrollExtent - 120.h) <= _scrollController.position.pixels && !customPicker.isLoadingPagintaion && !customPicker.isEnd){
        customPicker.isLoadingPagintaion = true;
        setState(() {});
        await customPicker.getCurrentMediaFiles(widget.album);
        setState(() {});
      }
    });
  }


  toCropView(Uint8List file) async{
    Uint8List? cropped = await Navigator.push(context, CupertinoPageRoute(builder: (context) 
      => CropperView(
        image: file, 
        onCancel: (){
          Navigator.pop(context);
          widget.onCancel();
        },
      )));
    if(cropped != null){
      Navigator.pop(context, cropped);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            

            // CONTENT
            Container(
              padding: EdgeInsets.only(top: 81.h, bottom: 47.h),
              color: ColorStyles.black2,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(customPicker.currentMediaFiles.isEmpty)
                      SizedBox()
                      // Wrap(
                      //   spacing: 3.w,
                      //   runSpacing: 3.h,
                      //   children: List.generate(14, (index) 
                      //     => Container(
                      //       color: ColorStyles.white2,
                      //       width: 120.w,
                      //       height: 120.w,
                      //     ),
                      //   )
                      // )
                      else
                      Wrap(
                        spacing: 3.w,
                        runSpacing: 3.h,
                        children: customPicker.currentMediaFiles.map((e) 
                          => ImageCard(
                            onTap: (file) => toCropView(file), 
                            file: customPicker.currentMediaFiles[customPicker.currentMediaFiles.indexOf(e)]
                          )
                          // GestureDetector(
                          //   onTap: () => toCropView(e),
                          //   child: CachedMemoryImage(
                          //     height: 120.w,
                          //     width: 120.w,
                          //     uniqueKey: 'app://image/${customPicker.currentMediaFilesUINT.indexOf(e)}_${widget.album.id}',
                          //     bytes: e,
                          //     placeholder: Container(
                          //       color: ColorStyles.black,
                          //       width: 120.w,
                          //       height: 120.w,
                          //     ),
                          //     fit: BoxFit.cover,
                          //   )
                          //   // Image.memory(
                          //   //   e,
                          //   //   width: 120.w,
                          //   //   height: 120.w,
                          //   //   fit: BoxFit.cover,
                          //   // ),
                          // ),
                        ).toList()
                      ),
                      if(customPicker.isLoadingPagintaion)
                      Wrap(
                        spacing: 3.w,
                        runSpacing: 3.h,
                        children: List.generate(18, (index) 
                          => Container(
                            color: ColorStyles.white2,
                            width: 120.w,
                            height: 120.w,
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),


            // APPBAR
            _buildBar(context, () async {
              // Navigator.push(context, CupertinoPageRoute(builder: (context) => AlbumsView()));
              if(widget.isFromMain){
                Uint8List? cropped = await Navigator.push(context, CupertinoPageRoute(builder: (context) => AlbumsView(
                  onCancel: (){
                    Navigator.pop(context);
                    widget.onCancel();
                  },
                )));
                if(cropped != null){
                  Navigator.pop(context, cropped);
                }
              }else{
                Navigator.pop(context);
              }
            }),

            // BOTTOMBAR
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: ColorStyles.white,
                height: 48.h,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        // widget.onCancel();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w,),
                        child: Text('Cancel', style: TextStyles(context).primary_14_w500,),
                      ),
                    ),
                  ],
                ),
              )
            )

          ],
        ),
      )
    );
  }

  Widget _buildBar(BuildContext context, Function() onTapAlbum){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 81.h,
      color: ColorStyles.white,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if(widget.album.name.trim().length <= 9)
          Center(
            child: Text(widget.album.name, style: TextStyles(context).headline2,),
          )
          else
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // color: ColorStyles.black2,
                width: 105.w,
                height: 10.h,
              ),
              Text(truncateWithEllipsis(15-2, widget.album.name), style: TextStyles(context).headline2,),
            ],
          ),
          Positioned(
            left: 8.w,
            bottom: 33.h,
            child: GestureDetector(
              onTap: onTapAlbum,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/chevron_back.svg', height: 16.h,),
                  SizedBox(width: 8.w,),
                  Text('Albums', style: TextStyles(context).primary_14_w500,)
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}