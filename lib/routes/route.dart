import 'package:flutter/material.dart';
import 'package:project_ecommerce/pages/_pages.dart';

class RouteGenerator {
  static Map<String, Widget Function(BuildContext)> generateRoute() {
    return {
      '/': (context) => const MyWelcomePage(),
      '/login-page': (context) => const MyLoginPage(),
      '/register-page': (context) => const MyRegisterPage(),
      '/dashboard-admin': (context) => const MyBottomNavbarAdmin(),
      '/add-product-admin': (context) => const AddProduct(),
      '/home-page': (context) => const MyBottomNavbarUser(),
      '/edit-profile': (context) => const MyeditProfile(),
      '/order-page': (context) => const MyOrderList(),
    };
  }

  static String? routeInit(String? currentUser, isAdmin) {
    if (currentUser == null) {
      return '/';
    } else {
      if (isAdmin) {
        return '/dashboard-admin';
      } else {
        return '/home-page';
      }
    }
  }

  static List pagesUser = [
    const MyHomePage(),
    const MyCartPage(),
    const MyProfilePage(),
  ];

  static List pagesAdmin = [
    const MyDashboard(),
    const MyTransactionPage(),
    const MyProfilePage(),
  ];
}
