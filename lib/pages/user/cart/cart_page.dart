// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
import 'package:project_ecommerce/models/cart_model.dart';
import 'package:project_ecommerce/functions/_functions.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  int subTotalPrice = 0;
  int discountPrice = 0;
  int shippingPrice = 0;

  String? userId = AuthServices().getCurrentUserUID();

  @override
  void initState() {
    super.initState();
    handlePricing();
  }

  void handlePricing() {
    FirestoreService().readCartData(userId).listen((List<Cart> carts) {
      int resultSubTotal = 0;
      int resultDiscount = 0;
      int resultShipping = 0;

      for (Cart cart in carts) {
        int price = int.parse(cart.price);
        double discount = double.parse(cart.discount);

        int handlePrice = price;
        double handleDiscount = handlePrice * (discount / 100);

        if (carts.isEmpty) {
          resultShipping = 0;
        } else {
          resultShipping = 11000;
        }

        resultSubTotal += handlePrice;
        resultDiscount += handleDiscount.toInt();
      }

      setState(() {
        subTotalPrice = resultSubTotal;
        discountPrice = resultDiscount;
        shippingPrice = resultShipping;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "My Cart",
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Cart List Product Start
          Container(
            height: 478,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: StreamBuilder<List<Cart>>(
              stream: FirestoreService().readCartData(userId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var carts = snapshot.data!;
                  if (carts.isEmpty) {
                    return Center(
                      child: Text(
                        "Basket is Empty!",
                        style: TextStyle(color: black, fontSize: 20),
                      ),
                    );
                  }
                  return ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: List.generate(carts.length, (index) {
                      Cart cart = carts[index];
                      return CartView(
                        deleteCardData: () async {
                          final result =
                              await FirestoreService().deleteCartData(
                            AuthServices().getCurrentUserUID(),
                            cart.id,
                          );
                          FirestoreService.handleDeleteProductResult(
                            result,
                            context,
                          );
                        },
                        cart: cart,
                      );
                    }),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          // Cart List Product End

          // Price Total Start
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey[400]!,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Product Subtotal Start
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal",
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(
                        subTotalPrice.toString(),
                        0,
                      ),
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                // Product Subtotal End

                const MyDivider(),

                // Product Discount Start
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount",
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      (discountPrice == 0)
                          ? CurrencyFormat.convertToIdr(
                              discountPrice.toString(),
                              0,
                            )
                          : "-${CurrencyFormat.convertToIdr(
                              discountPrice.toString(),
                              0,
                            )}",
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                // Product Discount End

                const MyDivider(),

                // Shipping Price Start
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping",
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(
                        shippingPrice.toString(),
                        0,
                      ),
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                // Shipping Price End

                const MyDivider(),

                // Price Total Start
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      CurrencyFormat.convertToIdr(
                        (subTotalPrice - discountPrice + shippingPrice)
                            .toString(),
                        0,
                      ),
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                // Price Total End
              ],
            ),
          ),
          // Price Total End

          // Proceed to Checkout Button Start
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: MyButtonCustom(
              onPressed: () {},
              bgColor: black,
              bgRadius: 10,
              onTapColor: textGrey,
              onTapRadius: 10,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(9),
              child: Center(
                child: Text(
                  "Proceed to Checkout",
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          // Proceed to Checkout Button End
        ],
      ),
    );
  }
}
