import 'package:flutter/material.dart';

class MyTransactionPage extends StatefulWidget {
  const MyTransactionPage({super.key});

  @override
  State<MyTransactionPage> createState() => _MyTransactionPageState();
}

class _MyTransactionPageState extends State<MyTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("transaction"));
  }
}
