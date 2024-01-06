// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
import 'package:project_ecommerce/models/product_model.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userId = AuthServices().getCurrentUserUID();

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            height: 75,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Button Start
                MyButtonCustom(
                  onPressed: () {},
                  width: 36,
                  height: 36,
                  bgRadius: 50,
                  onTapColor: textGrey,
                  onTapRadius: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 10,
                  ),
                  bgColor: black,
                  child: SvgPicture.asset(
                    "assets/icons/menu.svg",
                    height: 14,
                    width: 18,
                  ),
                ),
                // Button End

                // Profile Picture Start
                StreamBuilder(
                  stream: FirestoreService().fecthDataFromSpecificDoc(
                    'users',
                    userId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final user = snapshot.data!;
                      if (user.imgUrl == 'null') {
                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: bgGrey,
                            borderRadius: BorderRadius.circular(55),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/blank-profile.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: bgGrey,
                            borderRadius: BorderRadius.circular(55),
                            image: DecorationImage(
                              image: NetworkImage(user.imgUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                // Profile Picture End
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Column(
          children: [
            // Text & Search Start
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: black,
                  ),
                ),
                Text(
                  "Our Gadget App",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: textGrey,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: bgGrey,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      suffixIcon: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 15),
                        child: MyButtonCustom(
                          onPressed: () {},
                          bgColor: Colors.transparent,
                          bgRadius: 50,
                          onTapColor: textGrey,
                          onTapRadius: 50,
                          padding: const EdgeInsets.all(5),
                          width: 50,
                          height: 33,
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            colorFilter:
                                ColorFilter.mode(black, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      hintText: "Search here...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: bgGrey),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: bgGrey),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0, color: black),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "New Arrivals",
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            // Text & Search End

            const SizedBox(height: 6),

            // Product List Start
            StreamBuilder<List<Product>>(
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
                    primary: false,
                    shrinkWrap: true,
                    children: products.map((Product product) {
                      return ProductView(
                        isAdmin: false,
                        product: product,
                        deletebtn: () {},
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
            // Product List End
          ],
        ),
      ),
    );
  }
}
