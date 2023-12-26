// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_ecommerce/functions/_functions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final result = await AuthServices().signout();
              AuthServices.handleSignOutResult(result, context);
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
