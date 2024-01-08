// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/models/product_model.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        actions: [
          MyButtonCustom(
            onPressed: () {
              Navigator.pushNamed(context, '/add-product-admin');
            },
            bgColor: Colors.transparent,
            bgRadius: 50,
            onTapColor: textGrey,
            onTapRadius: 50,
            padding: const EdgeInsets.all(5),
            child: Icon(
              Icons.add,
              color: black,
              size: 30,
            ),
          ),
          const SizedBox(width: 13),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "All Products",
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<Product>>(
                stream: FirestoreService().readProductData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var products = snapshot.data!;
                    if (products.isEmpty) {
                      return Center(
                        child: Text(
                          "No Data Found!",
                          style: TextStyle(color: black, fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];
                        return ProductView(
                          isAdmin: true,
                          product: product,
                          deletebtn: () async {
                            final confirmDelete = await FirestoreService
                                .handleConfirmDeleteProduct(context);

                            if (confirmDelete) {
                              final result =
                                  await FirestoreService().deleteProductData(
                                product.id,
                                product.imgName,
                              );
                              FirestoreService.handleDeleteProductResult(
                                result,
                                context,
                              );
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
