import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final storageRef = FirebaseStorage.instance.ref();

  Future<Map<String, dynamic>> uploadImgToStorage(
    String storagePath,
    File? imgFile,
  ) async {
    if (imgFile == null) {
      return {'error': 'Image File is empty'};
    }

    String fileName = p.basename(imgFile.path);
    final productRef = storageRef.child('$storagePath/$fileName');

    try {
      await productRef.putFile(imgFile);
      String downloadUrl = await productRef.getDownloadURL();
      return {
        'fileName': fileName,
        'downloadUrl': downloadUrl,
      };
    } on FirebaseException catch (e) {
      return {'error': e.message.toString()};
    }
  }

  Future<String> deleteImgFromStorage(
    String storagePath,
    String imgName,
  ) async {
    try {
      final productRef = storageRef.child('$storagePath/$imgName');

      await productRef.delete();
      return 'true';
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }
}
