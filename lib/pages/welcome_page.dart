import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/_components.dart';

class MyWelcomePage extends StatelessWidget {
  const MyWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 0),
            Column(
              children: [
                Text(
                  "Hello, Welcome to",
                  style: TextStyle(
                    color: blue,
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "GadgetApp",
                  style: TextStyle(
                    color: black,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0),
            Image.asset("assets/images/welcome.png"),
            const SizedBox(height: 0),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/login-page',
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/register-page',
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: blue, width: 2.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
