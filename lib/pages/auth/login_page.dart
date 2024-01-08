// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/functions/_functions.dart';
import 'package:project_ecommerce/functions/auth_services.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handlePressedSignInBtn() async {
    if (_formKey.currentState!.validate()) {
      final result = await AuthServices().signin(
        email: emailController.text,
        password: passwordController.text,
      );
      AuthServices.handleSignInResult(result, context);
    }
  }

  void handlePressedResetPassword() async {
    if (emailController.text != '') {
      final result = await AuthServices().resetPassword(
        emailController.text,
      );
      AuthServices.handleResetPasswordResult(
        result,
        emailController.text,
        context,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter the email you want to change the password!',
          ),
        ),
      );
    }
  }

  void handleRememberMe(value) async {
    setState(() {
      isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            // Text Sign In
            Text(
              "Sign In",
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
              height: 330,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 35),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Text Field Email
                  MyAuthTextField(
                    controller: emailController,
                    labelText: "Email",
                    icon: Icons.person,
                    validator: (value) => Validator.errorMessage(
                      value,
                      'Please enter Email Address!',
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Text Field Password
                  MyAuthTextField(
                    controller: passwordController,
                    labelText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                    isPassword: true,
                    validator: (value) => Validator.errorMessage(
                      value,
                      'Please enter Password!',
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: black,
                            side: BorderSide(width: 1.5, color: textGrey),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            focusColor: textGrey,
                            splashRadius: 5,
                            visualDensity: VisualDensity.compact,
                            onChanged: handleRememberMe,
                          ),
                          Text(
                            "Remember Me",
                            style: TextStyle(
                              color: textGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      MyButtonCustom(
                        onPressed: handlePressedResetPassword,
                        bgColor: Colors.transparent,
                        bgRadius: 3,
                        onTapColor: bgGrey,
                        onTapRadius: 3,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Button Sign In
                  MyButtonCustom(
                    onPressed: handlePressedSignInBtn,
                    bgColor: black,
                    bgRadius: 20,
                    onTapColor: textGrey,
                    onTapRadius: 20,
                    padding: const EdgeInsets.all(7),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // Don't have an account?
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(width: 4),
                  MyButtonCustom(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/register-page');
                    },
                    bgColor: Colors.transparent,
                    bgRadius: 15,
                    onTapColor: blue,
                    onTapRadius: 15,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    child: Text(
                      "Sign Up",
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
