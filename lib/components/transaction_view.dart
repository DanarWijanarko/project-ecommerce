// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/_functions.dart';
import 'package:project_ecommerce/models/_models.dart';

class TransactionView extends StatelessWidget {
  TransactionView({super.key, required this.checkout});

  Checkout checkout;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
        right: 20,
        left: 20,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: black.withOpacity(0.3),
            offset: const Offset(1.5, 1.7),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer Details, Date, Status, Price Start
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Customer Details Start
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Details",
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Name : ${checkout.cusName}",
                    style: TextStyle(
                      color: textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Phone : ${checkout.cusPhone}",
                    style: TextStyle(
                      color: textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Address : ${checkout.cusAddress}",
                    style: TextStyle(
                      color: textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Customer Details End

              // Date, Status, Price Start
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Date.formatted(checkout.timestamp.toDate().toString()),
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    checkout.status,
                    style: TextStyle(
                      color: checkout.status == 'Success'
                          ? Colors.green[400]
                          : blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(checkout.totalPrice, 0),
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Date, Status, Price End
            ],
          ),
          // Customer Details, Date, Status, Price End

          // Divider Start
          Container(
            height: 0.5,
            margin: const EdgeInsets.only(top: 15, bottom: 8),
            color: textGrey,
          ),
          // Divider End

          // Products Text Start
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Products",
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                (checkout.products.length > 1)
                    ? "${checkout.products.length} Items"
                    : "${checkout.products.length} Item",
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // Products Text End

          const SizedBox(height: 7),

          // Products List Start
          SizedBox(
            height: 220,
            child: GridView.builder(
              itemCount: checkout.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 220,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = checkout.products[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      // Product Image Start
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(product['imgUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Product Image End

                      const SizedBox(height: 7),

                      // Product Name Start
                      Text(
                        product['name'],
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Product Name End

                      // Product Type Start
                      Text(
                        product['type'],
                        style: TextStyle(
                          color: textGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Product Type End
                    ],
                  ),
                );
              },
            ),
          ),
          // Products List End
        ],
      ),
    );
  }
}
