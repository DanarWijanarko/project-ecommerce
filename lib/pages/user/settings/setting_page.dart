import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/button_custom.dart';
import 'package:project_ecommerce/constants/color.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({super.key});

  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture Start
            Container(
              width: 180,
              height: 180,
              margin: const EdgeInsets.only(top: 30, bottom: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180),
                image: const DecorationImage(
                  image: AssetImage('assets/images/mouse.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: black.withOpacity(0.5),
                    offset: const Offset(1, 2),
                  )
                ],
              ),
            ),
            // Profile Picture End

            // Profile Detail Start

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[400]!,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.person,
                          color: black,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Danar Wijanarko",
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.email,
                          color: black,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "danarwijanarko98@gmail.com",
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: black,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Jl. Ahmad Yani Trenggalek",
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.phone,
                          color: black,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "081337716694",
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.phone,
                          color: black,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "081337716694",
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Profile Detail End

            const SizedBox(height: 25),

            // Edit Profile Button Start
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: MyButtonCustom(
                onPressed: () {},
                bgColor: black,
                bgRadius: 15,
                onTapColor: textGrey,
                onTapRadius: 15,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            // Edit Profile Button End

            const SizedBox(height: 15),

            // Sign Out Start
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: MyButtonCustom(
                onPressed: () {},
                bgColor: Colors.transparent,
                bgRadius: 15,
                onTapColor: textGrey,
                onTapRadius: 15,
                border: true,
                borderColor: red,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: red,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            // Sign Out End
          ],
        ),
      ),
    );
  }
}
