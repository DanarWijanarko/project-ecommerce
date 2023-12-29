// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/_functions.dart';
import 'package:project_ecommerce/models/cart_model.dart';

class CartView extends StatelessWidget {
  CartView({
    super.key,
    required this.cart,
    required this.deleteCardData,
  });

  Cart cart;
  VoidCallback deleteCardData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 125,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[400]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Product Image Start
          Container(
            width: 115,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(cart.imgUrl),
              ),
            ),
          ),
          // Product Image End

          const SizedBox(width: 7),

          // Product Detail Start
          Container(
            width: MediaQuery.of(context).size.width - 162,
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Product Name, and  TypeStart
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name Start
                    Text(
                      cart.name,
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Product Name End

                    // Product Type Start
                    Text(
                      cart.type,
                      style: TextStyle(
                        color: textGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Product Type End
                  ],
                ),
                // Product Name, and Type End

                // Product Price, Discount, and Button Delete Start
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Price After Discount Start
                        Text(
                          CurrencyFormat.convertToIdr(
                            DiscountCount.mathDiscount(
                              cart.price,
                              cart.discount,
                            ),
                            0,
                          ),
                          style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Product Price After Discount End

                        // Product Real Price & Discount Start
                        Row(
                          children: [
                            // Product Real Price Start
                            Text(
                              CurrencyFormat.convertToIdr(
                                cart.price,
                                0,
                              ),
                              style: TextStyle(
                                color: textGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: red,
                              ),
                            ),
                            // Product Real Price End

                            const SizedBox(width: 3),

                            // Product Discount Start
                            Text(
                              "${cart.discount}%",
                              style: TextStyle(
                                color: red,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Product Discount End
                          ],
                        ),
                        // Product Real Price & Discount End
                      ],
                    ),

                    // Button Delete Start
                    MyButtonCustom(
                      onPressed: deleteCardData,
                      bgColor: Colors.transparent,
                      bgRadius: 50,
                      onTapColor: textGrey,
                      onTapRadius: 50,
                      padding: const EdgeInsets.all(3),
                      child: Icon(
                        Icons.delete,
                        color: red,
                        size: 25,
                      ),
                    ),
                    // Button Delete End
                  ],
                ),
                // Product Price, Discount, and Button Delete End
              ],
            ),
          ),
          // Product Detail End
        ],
      ),
    );
  }
}
