// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/functions/auth_services.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key});

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void handlePressedSignUpBtn() async {
    if (passwordController.text == confirmPasswordController.text) {
      final result = await AuthServices().signup(
        email: emailController.text,
        password: passwordController.text,
      );
      AuthServices.handleSignUpResult(result, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password & Confirm Password do not match!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            // Text Sign Up
            Text(
              "Sign Up",
              style: TextStyle(
                color: black,
                fontSize: 25,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 18),

            // Image Container
            Container(
              height: 320,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/register.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Text Field Email
            MyAuthTextField(
              controller: emailController,
              labelText: "Email",
              icon: Icons.person,
            ),

            const SizedBox(height: 21),

            // Text Field Password
            MyAuthTextField(
              controller: passwordController,
              labelText: "Password",
              icon: Icons.lock,
              obscureText: true,
              isPassword: true,
            ),

            const SizedBox(height: 21),

            // Text Field Confirm Password
            MyAuthTextField(
              controller: confirmPasswordController,
              labelText: "Confirm Password",
              icon: Icons.lock_reset,
              obscureText: true,
              isPassword: true,
            ),

            const SizedBox(height: 27),

            // Button Sign Up
            MyButtonCustom(
              onPressed: handlePressedSignUpBtn,
              bgColor: black,
              bgRadius: 10,
              onTapColor: textGrey,
              onTapRadius: 10,
              padding: const EdgeInsets.all(7),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 27),

            // Have an account?
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(width: 4),
                  MyButtonCustom(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      "/login-page",
                    ),
                    bgColor: Colors.transparent,
                    bgRadius: 15,
                    onTapColor: blue,
                    onTapRadius: 15,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: black,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
