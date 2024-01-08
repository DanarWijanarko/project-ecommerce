import 'package:flutter/material.dart';
import 'package:project_ecommerce/routes/route.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/components/_components.dart';

class MyBottomNavbarUser extends StatefulWidget {
  const MyBottomNavbarUser({super.key});

  @override
  State<MyBottomNavbarUser> createState() => _MyBottomNavbarUserState();
}

class _MyBottomNavbarUserState extends State<MyBottomNavbarUser> {
  int selectedIndex = 0;

  final pages = RouteGenerator.pagesUser;

  void handlePagesChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.15),
                blurRadius: 7,
                spreadRadius: 0,
                offset: const Offset(0, -2),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (index) => MyNavbarButton(
              onPressed: () {
                handlePagesChanged(index);
              },
              title: [
                "Home",
                "Shopping Cart",
                "Profile",
              ][index],
              icon: [
                Icons.home_filled,
                Icons.shopping_cart_rounded,
                Icons.person_2,
              ][index],
              selectedIndex: selectedIndex,
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}

class MyBottomNavbarAdmin extends StatefulWidget {
  const MyBottomNavbarAdmin({super.key});

  @override
  State<MyBottomNavbarAdmin> createState() => _MyBottomNavbarAdminState();
}

class _MyBottomNavbarAdminState extends State<MyBottomNavbarAdmin> {
  int selectedIndex = 0;

  final pages = RouteGenerator.pagesAdmin;

  void handlePagesChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.15),
                blurRadius: 7,
                spreadRadius: 0,
                offset: const Offset(0, -2),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (index) => MyNavbarButton(
              onPressed: () {
                handlePagesChanged(index);
              },
              title: [
                "Home",
                "Order",
                "Profile",
              ][index],
              icon: [
                Icons.home_filled,
                Icons.upcoming,
                Icons.person_2,
              ][index],
              selectedIndex: selectedIndex,
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}
