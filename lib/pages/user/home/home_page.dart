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
  String? name;

  TextEditingController searchController = TextEditingController();

  void searchButton() {
    setState(() {
      name = searchController.text;
    });
  }

  Stream<List<Product>> handleSearchingProduct() {
    if (name == null || name == '') {
      return FirestoreService().readProductData();
    } else {
      return FirestoreService().readProductDataByName(name!);
    }
  }

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
                        return Row(
                          children: [
                            Text(
                              user.username,
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
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
                            ),
                          ],
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
                // Welcome Text Start
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
                // Welcome Text End

                const SizedBox(height: 20),

                // Search TextField Start
                MySearchTextField(
                  searchController: searchController,
                  searchButton: searchButton,
                ),
                // Search TextField End

                const SizedBox(height: 20),

                // New Arrivals Text Start
                Text(
                  "New Arrivals",
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                // New Arrivals Text End
              ],
            ),
            // Text & Search End

            const SizedBox(height: 6),

            // Product List Start
            StreamBuilder<List<Product>>(
              stream: handleSearchingProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data!;
                  if (products.isEmpty) {
                    return Center(
                      child: Text(
                        "No Data Found!",
                        style: TextStyle(color: black, fontSize: 20),
                      ),
                    );
                  }
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Product product = products[index];
                      return ProductView(
                        isAdmin: false,
                        product: product,
                        deletebtn: () {},
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
            // Product List End
          ],
        ),
      ),
    );
  }
}
