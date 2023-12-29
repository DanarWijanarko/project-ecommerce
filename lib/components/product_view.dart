// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/button_custom.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/_functions.dart';
import 'package:project_ecommerce/models/product_model.dart';
import 'package:project_ecommerce/pages/_pages.dart';

class ProductView extends StatelessWidget {
  ProductView({
    super.key,
    required this.isAdmin,
    required this.product,
    required this.deletebtn,
  });

  bool isAdmin;
  Product product;
  VoidCallback deletebtn;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: black.withOpacity(0.5),
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(product: product),
            ),
          );
        },
        child: Row(
          children: [
            // Product Image
            Container(
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imgUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            const SizedBox(width: 10),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 190,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Name & Type
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            product.name,
                            style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          // Product Type
                          Text(
                            product.type,
                            style: TextStyle(
                              color: textGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      (isAdmin)
                          ?
                          // Button Delete Product
                          MyButtonCustom(
                              onPressed: deletebtn,
                              bgColor: Colors.transparent,
                              bgRadius: 50,
                              onTapColor: textGrey,
                              onTapRadius: 50,
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.delete_forever,
                                color: red,
                                size: 17,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 190,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Sold & Rating
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Sold
                          Text(
                            "${product.sold} Sold",
                            style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),

                          // Product Rating
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: yellow,
                                size: 17,
                              ),
                              Text(
                                "(${product.rating})",
                                style: TextStyle(
                                  color: black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Product Price & Discount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Product Price
                          Text(
                            CurrencyFormat.convertToIdr(
                              DiscountCount.mathDiscount(
                                product.price,
                                product.discount,
                              ),
                              0,
                            ),
                            style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          // Product Discount
                          Row(
                            children: [
                              Text(
                                CurrencyFormat.convertToIdr(
                                  product.price,
                                  0,
                                ),
                                style: TextStyle(
                                  color: textGrey,
                                  fontSize: 9,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: red,
                                  decorationThickness: 1,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "${product.discount}%",
                                style: TextStyle(
                                  color: red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
