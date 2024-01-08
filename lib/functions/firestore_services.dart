// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ecommerce/models/_models.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/storage_services.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> fecthDataFromSpecificDoc(
    String collectionPath,
    String? docPath,
  ) {
    final docRef = firestore.collection(collectionPath).doc(docPath);

    return docRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return User.fromJson(snapshot.data()!);
      } else {
        return null;
      }
    });
  }

  Future<User?> getCurrentUserData(String? docPath) async {
    final docRef = firestore.collection('users').doc(docPath);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
    return null;
  }

  Future<bool> getIsAdmin(String? docPath) async {
    final docRef = firestore.collection('users').doc(docPath);
    final user = await docRef.get();

    if (user.exists) {
      return user['isAdmin'];
    }
    return false;
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
    required String? userId,
    required String imgName,
    required String imgUrl,
    required String name,
    required String type,
    required String price,
    required String discount,
  }) async {
    try {
      final docCart =
          firestore.collection('users').doc(userId).collection('carts').doc();

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

  Future<String?> addCheckoutProduct({
    required String cusId,
    required String cusName,
    required String cusAddress,
    required String cusPhone,
    required List<Map<String, dynamic>> products,
    required Timestamp timestamp,
    required String status,
    required String totalPrice,
  }) async {
    try {
      final docCheckout = firestore.collection('checkout').doc();

      String docId = docCheckout.id;

      final checkout = Checkout(
        id: docId,
        cusId: cusId,
        cusName: cusName,
        cusAddress: cusAddress,
        cusPhone: cusPhone,
        products: products,
        timestamp: timestamp,
        totalPrice: totalPrice,
        status: status,
      );

      final checkoutJson = checkout.toJson();

      await docCheckout.set(checkoutJson);
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

  Stream<List<Product>> readProductDataByName(String keyword) {
    // untuk membaca collection & snapshots() semua isi dari document
    // dan me-return Json data dan di convert ke product object
    return firestore
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: keyword)
        .where('name', isLessThanOrEqualTo: '$keyword\uf7ff')
        .snapshots()
        .map((snapshot) {
      // untuk membaca isi dari document 'doc.data()' yang bertipe JSON
      // lalu dirubah menjadi Object menggunakan method 'fromJson'
      return snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    });
  }

  Stream<List<Cart>> readCartData(String? userId) {
    // untuk membaca collection & snapshots() semua isi dari document
    // dan me-return Json data dan di convert ke product object
    return firestore
        .collection('users')
        .doc(userId)
        .collection('carts')
        .snapshots()
        .map((snapshot) {
      // untuk membaca isi dari document 'doc.data()' yang bertipe JSON
      // lalu dirubah menjadi Object menggunakan method 'fromJson'
      return snapshot.docs.map((doc) => Cart.fromJson(doc.data())).toList();
    });
  }

  Stream<List<Checkout>> readCheckoutData() {
    // untuk membaca collection & snapshots() semua isi dari document
    // dan me-return Json data dan di convert ke product object
    return firestore.collection('checkout').snapshots().map((snapshot) {
      // untuk membaca isi dari document 'doc.data()' yang bertipe JSON
      // lalu dirubah menjadi Object menggunakan method 'fromJson'
      return snapshot.docs.map((doc) => Checkout.fromJson(doc.data())).toList();
    });
  }

  Future<String?> updateUser({
    required String docUser,
    required File? imgFile,
    required String imgUrl,
    required String imgName,
    required String username,
    required String address,
    required String phone,
    required String birthDate,
  }) async {
    try {
      String uploadedImgUrl = '';
      String uploadedImgName = '';

      if (imgUrl == 'null') {
        final imgResult = await StorageServices().uploadImgToStorage(
          'users',
          imgFile,
        );
        uploadedImgUrl = imgResult['downloadUrl'];
        uploadedImgName = imgResult['fileName'];
      }

      final user = firestore.collection('users').doc(docUser);

      user.update({
        'imgUrl': imgUrl == 'null' ? uploadedImgUrl : imgUrl,
        'imgName': imgName == 'null' ? uploadedImgName : imgName,
        'username': username,
        'address': address,
        'phone': phone,
        'birthDate': birthDate,
      });

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> deleteProductData(String? docId, String imgName) async {
    try {
      StorageServices().deleteImgFromStorage('products', imgName);

      final docProduct = firestore.collection('products').doc(docId);

      await docProduct.delete();

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> deleteSpecificCartData(
    String? docUserId,
    String? docCartId,
  ) async {
    try {
      final docCart = firestore
          .collection('users')
          .doc(docUserId)
          .collection('carts')
          .doc(docCartId);

      await docCart.delete();

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future<String?> deleteAllCartData(String? docUserId) async {
    try {
      final docCart =
          firestore.collection('users').doc(docUserId).collection('carts');

      final snapshot = await docCart.get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

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
          content: Text('Delete Success'),
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

  static handleDeleteCartProductResult(String? result, BuildContext context) {
    if (result == 'true') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Delete Success'),
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

  static handleAddCheckoutResult(
    String? result,
    BuildContext context,
    String? userId,
  ) async {
    if (result == 'true') {
      await FirestoreService().deleteAllCartData(userId);
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Checkout Success'),
          content: const Text('Thank you for your Purchase'),
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
