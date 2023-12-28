import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadImgToStorage(File? imgFile) async {
    if (imgFile == null) {
      return 'Image File is empty';
    }

    String fileName = p.basename(imgFile.path);
    final productRef = storageRef.child('/products/$fileName');

    try {
      await productRef.putFile(imgFile);
      String downloadUrl = await productRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }
}
