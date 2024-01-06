// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> signup({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      String userUid = user?.uid as String;
      String userEmail = user?.email as String;

      await FirestoreService().addUserToFirestore(
        docPath: userUid,
        email: userEmail,
      );

      return 'true';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signin({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'true';
    } on FirebaseAuthException catch (e) {
      // return e.message;
      if (e.code == 'invalid-credential') {
        return 'Wrong Username or Password!';
      } else {
        return e.code;
      }
    }
  }

  Future<String?> signout() async {
    try {
      await auth.signOut();
      return 'true';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  String? getCurrentUserUID() {
    if (auth.currentUser != null) {
      return auth.currentUser?.uid;
    } else {
      return null;
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      return 'true';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static handleResetPasswordResult(
    String? result,
    String email,
    BuildContext context,
  ) async {
    if (result == 'true') {
      return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Sending an Email'),
          content: Text('Please check your email at "$email"!'),
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
          content: Text(result ?? 'An error occurred'),
        ),
      );
    }
  }

  static handleSignInResult(String? result, BuildContext context) async {
    if (result == 'true') {
      final userUid = AuthServices().getCurrentUserUID();
      bool isAdmin = await FirestoreService().getIsAdmin(userUid);

      if (isAdmin) {
        Navigator.pushNamed(context, '/dashboard-admin');
      } else {
        Navigator.pushNamed(context, '/home-page');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ?? 'An error occurred'),
        ),
      );
    }
  }

  static handleSignUpResult(String? result, BuildContext context) {
    if (result == 'true') {
      return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Column(
            children: [
              Text('Create an Account Successfully'),
              Text('Go to Sign In Page?'),
            ],
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pushNamed(context, '/login-page');
              },
              child: Text(
                'Yes',
                style: TextStyle(color: blue),
              ),
            ),
          ],
        ),
      );
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ?? 'An error occurred'),
        ),
      );
    }
  }

  static handleSignOutResult(String? result, BuildContext context) {
    if (result == 'true') {
      return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Success'),
          content: const Text(
            'Please Sign in again to get into app!',
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.popUntil(
                context,
                (route) => route.isFirst,
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
          content: Text(result ?? 'An error occurred'),
        ),
      );
    }
  }
}
