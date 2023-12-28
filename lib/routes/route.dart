import 'package:flutter/material.dart';
import 'package:project_ecommerce/pages/_pages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const MyWelcomePage(),
        );
      case '/login-page':
        return MaterialPageRoute(
          builder: (context) => const MyLoginPage(),
        );
      case '/register-page':
        return MaterialPageRoute(
          builder: (context) => const MyRegisterPage(),
        );
      case '/dashboard-admin':
        return MaterialPageRoute(
          builder: (context) => const MyDashboard(),
        );
      case '/add-product-admin':
        return MaterialPageRoute(
          builder: (context) => const AddProduct(),
        );
      case '/home-page':
        return MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        );
      default:
        return routeError();
    }
  }

  static Route<dynamic> routeError() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("ERROR!"),
        ),
        body: const Center(
          child: Text(
            "Error",
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }
}
