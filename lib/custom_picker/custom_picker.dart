import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

class CustomPicker{


  List<AssetPathEntity> albums = [];
  //ALBUMS PREVIEW
  List<Uint8List> albumsUINT = [];

  //CURRENT CHOOSEN ALBUM MEDIA FILES
  List<AssetEntity> currentMediaFiles = [];
  // List<Uint8List> currentMediaFilesUINT = [];

  //RECENT MEDIA FILES
  List<AssetEntity> recentMediaFiles = [];
  List<Uint8List> recentMediaFilesUINT = [];

  //PAGINATION values
  int currentPage = 0;
  bool isLoading = true;
  bool isEnd = false;
  bool isLoadingPagintaion = false;
  int sizePagination = 6;

  ThumbnailSize quality = const ThumbnailSize(300, 300);

  ///Get all albums
  getAlbums() async {
    bool isAccess = await _checkPermissionDevice();
    if(isAccess){
      albums = await PhotoManager.getAssetPathList(type: RequestType.image);
      List<Uint8List> temp = [];

      //GETTING PREVIEWS 
      for (var album in albums){
        List<AssetEntity> media = await album.getAssetListPaged(page: currentPage, size: 1);
        for (var asset in media) {
          Uint8List? file = await asset.thumbnailDataWithSize(quality);
          if(file != null){
            temp.add(file);
          }
        }
      }
      albumsUINT = temp;
    }
  }

  ///Get recent main files
  getRecentMediaFiles() async {
    bool isAccess = await _checkPermissionDevice();
    if(isAccess){
      isLoading = true;
      albums = await PhotoManager.getAssetPathList(type: RequestType.image);
      if(albums.isEmpty) return;
      List<AssetEntity> media = await albums.first.getAssetListPaged(page: currentPage, size: 9);
      List<Uint8List> temp = [];
      for (var asset in media) {
        Uint8List? file = await asset.thumbnailDataWithSize(quality);
        if(file != null){
          temp.add(file);
        }
      }
      isLoading = false;

      recentMediaFiles = media;
      recentMediaFilesUINT = temp;
    }
  }


  ///Get media files from album
  getCurrentMediaFiles(AssetPathEntity album) async {
    bool isAccess = await _checkPermissionDevice();
    if(isAccess){
      List<AssetEntity> media = await album.getAssetListPaged(page: currentPage, size: currentPage == 0 ? 18 : sizePagination);
      // List<Uint8List> temp = [];
      // for (var asset in media) {
      //   Uint8List? file = await asset.thumbnailDataWithSize(quality);
      //   if(file != null){
      //     temp.add(file);
      //   }
      // }

      //PAGINATION END
      if(media.length < sizePagination){
        isEnd = true;
      }

      isLoading = false;
      isLoadingPagintaion = false;
      // currentMediaFilesUINT.addAll(temp);
      currentMediaFiles.addAll(media);
      currentPage++;
    }
  }


  ///Check and request permission to the device storage(gallery)
  Future<bool> _checkPermissionDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (!result.hasAccess) await PhotoManager.openSetting();

    return result.hasAccess;
  }



  resetPagination(){
    currentPage = 0;
    isLoading = true;
    isLoadingPagintaion = false;
    isEnd = false;
  }
}