import 'dart:io';

import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveDeleteVideo {
  Future<void> saveDownloadedVideoToGallery(
      {required String videoPath, required String id}) async {
    await ImageGallerySaver.saveFile(
      videoPath,
      name: id,
    );
  }

  Future<void> removeDownloadedVideo({required String videoPath}) async {
    try {
      Directory(videoPath).deleteSync(recursive: true);
    } catch (error) {
      print('$error');
    }
  }
}
