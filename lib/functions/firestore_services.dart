import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ecommerce/models/_models.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/storage_services.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> fecthDataFromSpecificDoc(
    String collectionPath,
    String? docPath,
  ) async {
    final docRef = firestore.collection(collectionPath).doc(docPath);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
    return null;
  }

  Future<bool> getIsAdmin(String? docPath) async {
    final docRef = firestore.collection('users').doc(docPath);
    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return data['isAdmin'];
    } else {
      return false;
    }
  }

  Future<String?> addUserToFirestore({
    required String docPath,
    required String email,
  }) async {
    try {
      final docProduct = firestore.collection('users').doc(docPath);

      final user = User(
        id: docPath,
        isAdmin: false,
        imgName: 'null',
        imgUrl: 'null',
        username: 'null',
        email: email,
        address: 'null',
        phone: 'null',
        birthDate: 'null',
      );

      final userJson = user.toJson();
      await docProduct.set(userJson);

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

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
      final imgResult = await StorageServices().uploadImgToStorage(
        'products',
        imageFile,
      );
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

  Future<String?> addToCartData({
    required String imgName,
    required String imgUrl,
    required String name,
    required String type,
    required String price,
    required String discount,
  }) async {
    try {
      final docCart = firestore.collection('carts').doc();

      String docId = docCart.id;

      final cart = Cart(
        id: docId,
        imgName: imgName,
        imgUrl: imgUrl,
        name: name,
        type: type,
        price: price,
        discount: discount,
      );

      final cartJson = cart.toJson();

      await docCart.set(cartJson);
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

  Stream<List<Cart>> readCartData() {
    // untuk membaca collection & snapshots() semua isi dari document
    // dan me-return Json data dan di convert ke product object
    return firestore.collection('carts').snapshots().map((snapshot) {
      // untuk membaca isi dari document 'doc.data()' yang bertipe JSON
      // lalu dirubah menjadi Object menggunakan method 'fromJson'
      return snapshot.docs.map((doc) => Cart.fromJson(doc.data())).toList();
    });
  }

  // Future<String?> updateUser({

  // }) async {

  // }

  Future<String?> deleteProductData(docId, imgName) async {
    try {
      StorageServices().deleteImgFromStorage('products', imgName);

      final docProduct = firestore.collection('products').doc(docId);

      await docProduct.delete();

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> deleteCartData(docId) async {
    try {
      final docCart = firestore.collection('carts').doc(docId);

      await docCart.delete();

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<bool> handleConfirmDeleteProduct(BuildContext context) async {
    bool confirmDelete = await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Data will be lost Forever!'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: blue),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'OK',
              style: TextStyle(color: blue),
            ),
          ),
        ],
      ),
    );

    return confirmDelete;
  }

  static handleDeleteProductResult(String? result, BuildContext context) {
    if (result == 'true') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sukses Hapus'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error DElete: $result'),
        ),
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
              onPressed: () => Navigator.popUntil(
                context,
                ModalRoute.withName('/dashboard-admin'),
              ),
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

  static handleAddToCartResult(String? result, BuildContext context) {
    if (result == 'true') {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Successfully added product to basket'),
          content: const Text('Please go to basket to checkout'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: black),
              ),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $result'),
        ),
      );
    }
  }
}
