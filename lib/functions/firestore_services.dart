import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/storage_services.dart';
import 'package:project_ecommerce/models/product_model.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> addProductData({
    required File? imageFile,
    required String name,
    required String type,
    required String price,
    required String discount,
    required String rating,
    required String sold,
    required String description,
  }) async {
    try {
      final imgResult = await StorageServices().uploadImgToStorage(imageFile);
      final docProduct = firestore.collection('products').doc();

      String docId = docProduct.id;

      final product = Product(
        id: docId,
        imgName: imgResult['fileName'],
        imgUrl: imgResult['downloadUrl'],
        name: name,
        type: type,
        price: price,
        discount: discount,
        rating: rating,
        sold: sold,
        description: description,
      );

      final productJson = product.toJson();

      await docProduct.set(productJson);

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Stream<List<Product>> readProductData() {
    // untuk membaca collection & snapshots() semua isi dari document
    // dan me-return Json data dan di convert ke product object
    return firestore.collection('products').snapshots().map((snapshot) {
      // untuk membaca isi dari document 'doc.data()' yang bertipe JSON
      // lalu dirubah menjadi Object menggunakan method 'fromJson'
      return snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    });
  }

  Future<String?> deleteProductData(docId, imgName) async {
    try {
      StorageServices().deleteImgFromStorage(imgName);

      final docProduct = firestore.collection('products').doc(docId);

      await docProduct.delete();

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static handleReadProductDataResult(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (snapshot.hasError) {
      return Center(
        child: Text("Error: ${snapshot.error}"),
      );
    }
  }

  static handleAddDataResult(String? result, BuildContext context) {
    if (result == 'true') {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Add new product Success'),
          content: const Text('Press OK to back to all products'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: blue),
              ),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Adding new product: $result'),
        ),
      );
    }
  }
}
