import 'package:flutter/material.dart';
import 'package:project_ecommerce/pages/_pages.dart';

class RouteGenerator {
  static Map<String, Widget Function(BuildContext)> generateRoute() {
    return {
      '/': (context) => const MyWelcomePage(),
      '/login-page': (context) => const MyLoginPage(),
      '/register-page': (context) => const MyRegisterPage(),
      '/dashboard-admin': (context) => const MyDashboard(),
      '/add-product-admin': (context) => const AddProduct(),
      '/home-page': (context) => const MyBottomNavBar(),
      '/edit-profile': (context) => const MyeditProfile(),
    };
  }

  static List pages = [
    const MyHomePage(),
    const MyCartPage(),
    const MySettingPage(),
  ];
}
