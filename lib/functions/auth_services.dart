// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> signup({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
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
      return e.message;
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

  Future<String> getUserUID() async {
    try {
      Completer<String> completer = Completer<String>();
      auth.authStateChanges().listen((User? user) {
        if (user != null) {
          completer.complete(user.uid);
        } else {
          completer.complete("null");
        }
      });
      String result = await completer.future;
      return result;
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
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
      final userUid = await AuthServices().getUserUID();
      if (userUid == 'ZMfUx9w67eSV4BAltkNZQCHFXZC3') {
        Navigator.pushNamed(context, '/dashboard-admin');
      } else if (userUid == 'null') {
        return;
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
