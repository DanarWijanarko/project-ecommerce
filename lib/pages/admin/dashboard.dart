import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/constants/color.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  Future getData() async {
    await FirebaseFirestore.instance.collection("users").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

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
            onPressed: () => Navigator.pushNamed(context, '/add-product-admin'),
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
          const SizedBox(width: 12.5),
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
            Container(
              decoration: BoxDecoration(
                color: bgGrey,
                borderRadius: BorderRadius.circular(45),
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
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
                        colorFilter: ColorFilter.mode(black, BlendMode.srcIn),
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
            const SizedBox(height: 25),
            Text(
              "All Products",
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('products').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                  // olah data
                  var data = snapshot.data!.docs;
            
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product Name: ${data[index]['name']}"),
                            Image.network(data[index]['imgUrl']),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
