import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';
import 'package:project_ecommerce/models/checkout_model.dart';

class MyOrderList extends StatefulWidget {
  const MyOrderList({super.key});

  @override
  State<MyOrderList> createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: MyButtonCustom(
          onPressed: () {
            Navigator.pop(context);
          },
          bgColor: Colors.transparent,
          bgRadius: 50,
          onTapColor: textGrey,
          onTapRadius: 50,
          padding: const EdgeInsets.all(0),
          child: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
        title: Text(
          "My Orders",
          style: TextStyle(color: black),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreService().readCheckoutData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final checkouts = snapshot.data!;
            if (checkouts.isEmpty) {
              return Center(
                child: Text(
                  "No Data Found!",
                  style: TextStyle(
                    color: black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: checkouts.length,
              itemBuilder: (context, index) {
                Checkout checkout = checkouts[index];
                if (checkout.cusId == AuthServices().getCurrentUserUID()) {
                  return Text(checkout.cusName);
                }
                return const SizedBox();
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
