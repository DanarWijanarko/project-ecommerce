// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/models/product_model.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
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
          MenuAnchor(
            builder: (context, controller, child) {
              return Row(
                children: [
                  MyButtonCustom(
                    onPressed: () {
                      controller.isOpen
                          ? controller.close()
                          : controller.open();
                    },
                    bgColor: Colors.transparent,
                    bgRadius: 50,
                    onTapColor: textGrey,
                    onTapRadius: 50,
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.menu,
                      color: black,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 13),
                ],
              );
            },
            style: MenuStyle(
              backgroundColor: MaterialStatePropertyAll(bgGrey),
              minimumSize: const MaterialStatePropertyAll(Size.zero),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(0)),
              shadowColor: MaterialStatePropertyAll(black.withOpacity(0.7)),
            ),
            alignmentOffset: const Offset(-170, 5),
            menuChildren: [
              MenuItemButton(
                style: MenuItemButton.styleFrom(
                  foregroundColor: textGrey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/add-product-admin');
                },
                child: SizedBox(
                  width: 175,
                  child: Center(
                    child: Text(
                      "Add Product",
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 1.3,
                color: textGrey,
              ),
              MenuItemButton(
                style: MenuItemButton.styleFrom(
                  foregroundColor: textGrey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                ),
                onPressed: () async {
                  final result = await AuthServices().signout();
                  AuthServices.handleSignOutResult(result, context);
                },
                child: SizedBox(
                  width: 175,
                  child: Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            const SizedBox(height: 8),
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
                    return ListView(
                      children: products.map((Product product) {
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
                                  result, context);
                            }
                          },
                        );
                      }).toList(),
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
