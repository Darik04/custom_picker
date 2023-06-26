import 'package:custom_picker/constants/colors/color_styles.dart';
import 'package:custom_picker/constants/texts/text_styles.dart';
import 'package:custom_picker/custom_picker/custom_picker.dart';
import 'package:custom_picker/custom_picker/views/media_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_manager/photo_manager.dart';



class AlbumsView extends StatefulWidget {
  final Function() onCancel;
  AlbumsView({super.key, required this.onCancel});

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {


  CustomPicker customPicker = CustomPicker();

  @override
  void initState() {
    super.initState();
    initMedia();
  }

  initMedia() async {
    await customPicker.getAlbums();
    setState(() {});
  }


  toMediaView(AssetPathEntity album) async{
    Uint8List? cropped = await Navigator.push(context, CupertinoPageRoute(builder: (context) 
      => MediaView(
        album: album, 
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
                child: Container(
                  margin: EdgeInsets.all(25.w),
                  child: customPicker.albums.isEmpty 
                  ? SizedBox(
                    height: MediaQuery.of(context).size.height - 200.h,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                  : Column(
                    children: customPicker.albums.map((e) 
                      => _buildAlbumItem(
                        album: e, 
                        preview: customPicker.albumsUINT[customPicker.albums.indexOf(e)],
                        onTap: () => toMediaView(e)
                      )
                    ).toList()
                  )
                ),
              ),
            ),


            // APPBAR
            _buildBar(context),

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

  Widget _buildBar(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 81.h,
      color: ColorStyles.white,
      alignment: Alignment.center,
      child: Text('Albums', style: TextStyles(context).headline2,)
    );
  }




  Widget _buildAlbumItem({required AssetPathEntity album, required Function() onTap, required Uint8List preview}){
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 80.h,
        margin: EdgeInsets.only(bottom: 25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.memory(
                  preview,
                  width: 80.h,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 24.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${album.name}', style: TextStyles(context).white_14_w500,),
                    SizedBox(height: 6.h,),
                    Text('${album.assetCount}', style: TextStyles(context).white_14_w500,)
                  ],
                )
              ],
            ),

            SvgPicture.asset('assets/svg/chevron_right.svg', height: 16.h,)
          ],
        ),
      ),
    );
  }
}