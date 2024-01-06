// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
import 'package:project_ecommerce/models/product_model.dart';
import 'package:project_ecommerce/functions/_functions.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? userId = AuthServices().getCurrentUserUID();

  void handleAddtoCartButton() async {
    final result = await FirestoreService().addToCartData(
      userId: userId,
      imgName: widget.product.imgName,
      imgUrl: widget.product.imgUrl,
      name: widget.product.name,
      type: widget.product.type,
      price: widget.product.price,
      discount: widget.product.discount,
    );
    FirestoreService.handleAddToCartResult(result, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image Background & Button Start
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2 + 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.product.imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                        right: 20,
                        bottom: 52,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Button Back & Cart Start
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Button Back Start
                              MyButtonCustom(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                width: 35,
                                height: 35,
                                bgRadius: 50,
                                onTapColor: textGrey,
                                onTapRadius: 50,
                                padding: const EdgeInsets.all(5),
                                bgColor: white,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: black,
                                ),
                              ),
                              // Button Back End

                              // Button Cart Start
                              MyButtonCustom(
                                onPressed: () {},
                                width: 35,
                                height: 35,
                                bgRadius: 50,
                                onTapColor: textGrey,
                                onTapRadius: 50,
                                padding: const EdgeInsets.all(6.5),
                                bgColor: white,
                                child: SvgPicture.asset(
                                  "assets/icons/cart.svg",
                                  colorFilter: ColorFilter.mode(
                                    black,
                                    BlendMode.srcATop,
                                  ),
                                ),
                              ),
                              // Button Cart End
                            ],
                          ),
                          // Button Back & Cart End

                          // Button Favorite Start
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MyButtonCustom(
                                onPressed: () {},
                                width: 35,
                                height: 35,
                                bgRadius: 50,
                                onTapColor: textGrey,
                                onTapRadius: 50,
                                padding: const EdgeInsets.all(5.5),
                                bgColor: white,
                                child: SvgPicture.asset(
                                  "assets/icons/love.svg",
                                  colorFilter: ColorFilter.mode(
                                    black,
                                    BlendMode.srcATop,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Button Favorite End
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Image Background & Button End

          // Product Detail Start
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 420,
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 25,
                  top: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name & Sold Start
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Product Name Start
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: black,
                          ),
                        ),
                        // Product Name End

                        // Product Sold Start
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: bgGrey,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "${widget.product.sold} Sold",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: black,
                            ),
                          ),
                        ),
                        // Product Sold End
                      ],
                    ),
                    // Product Name & Sold End

                    const SizedBox(height: 7),

                    // Product Type Start
                    Text(
                      widget.product.type,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: textGrey,
                      ),
                    ),
                    // Product Type End

                    const SizedBox(height: 8),

                    // Product Rating Start
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: yellow,
                          size: 22,
                        ),
                        Text(
                          "(${widget.product.rating})",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                    // Product Rating End

                    const SizedBox(height: 15),

                    // Price & Discount Text Start
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: black,
                          ),
                        ),
                        Text(
                          "Discount",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                    // Price & Discount Text Start

                    const SizedBox(height: 5),

                    // Price & Discount Content Start
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Real Price Start
                        Text(
                          CurrencyFormat.convertToIdr(
                            DiscountCount.mathDiscount(
                              widget.product.price,
                              widget.product.discount,
                            ),
                            0,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                            color: black,
                          ),
                        ),
                        // Real Price End

                        // Discount Price Start
                        if (int.parse(widget.product.price) > 0)
                          Row(
                            children: [
                              Text(
                                CurrencyFormat.convertToIdr(
                                  widget.product.price,
                                  0,
                                ),
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textGrey,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFDEDE),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    "18%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      color: red,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        // Discount Price End
                      ],
                    ),
                    // Price & Discount Content End

                    const SizedBox(height: 15),

                    // Product Description Text Start
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: black,
                      ),
                    ),
                    // Product Description End Start

                    const SizedBox(height: 7),

                    // Product Description Content Start
                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: textGrey,
                      ),
                    ),
                    // Product Description Content End

                    const SizedBox(height: 12),

                    // Add to Cart Button Start
                    MyButtonCustom(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      bgRadius: 25,
                      onTapColor: textGrey,
                      onTapRadius: 25,
                      padding: const EdgeInsets.all(0),
                      bgColor: black,
                      onPressed: handleAddtoCartButton,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/cart.svg"),
                          const SizedBox(width: 10),
                          Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add to Cart Button End
                  ],
                ),
              ),
            ),
          ),
          // Product Detail End
        ],
      ),
    );
  }
}
