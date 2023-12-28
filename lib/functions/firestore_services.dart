import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> addData(productJson) async {
    try {
      final docProduct = firestore.collection('products').doc();

      await docProduct.set(productJson);

      return 'true';
    } on FirebaseException catch (e) {
      return e.message;
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
        const SnackBar(
          content: Text('Error Adding new product'),
        ),
      );
    }
  }
}
