import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/transaction_view.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';
import 'package:project_ecommerce/models/_models.dart';

class MyTransactionPage extends StatefulWidget {
  const MyTransactionPage({super.key});

  @override
  State<MyTransactionPage> createState() => _MyTransactionPageState();
}

class _MyTransactionPageState extends State<MyTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
        title: Text(
          "Transaction Order List",
          style: TextStyle(
            color: black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreService().readCheckoutData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var tests = snapshot.data!;
            if (tests.isEmpty) {
              return Center(
                child: Text(
                  "No Data Found!",
                  style: TextStyle(color: black, fontSize: 20),
                ),
              );
            }
            return ListView.builder(
              itemCount: tests.length,
              itemBuilder: (context, index) {
                Checkout checkout = tests[index];
                return TransactionView(checkout: checkout);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
