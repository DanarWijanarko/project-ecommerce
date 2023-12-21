import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/_components.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key});

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 45,
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              const SizedBox(width: 21),
              MyButtonCustom(
                onPressed: () => Navigator.pop(context),
                bgColor: white,
                bgRadius: 50,
                onTapColor: blue,
                onTapRadius: 50,
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.arrow_back,
                  color: textGrey,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
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
            Container(
              height: 340,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/register.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 22.5),
            const MyAuthTextField(
              labelText: "Email",
              icon: Icons.person,
            ),
            const SizedBox(height: 15),
            const MyAuthTextField(
              labelText: "Password",
              icon: Icons.lock,
            ),
            const SizedBox(height: 15),
            const MyAuthTextField(
              labelText: "Confirm Password",
              icon: Icons.lock_reset,
            ),
            const SizedBox(height: 22.5),
            MyButtonCustom(
              onPressed: () {},
              bgColor: blue,
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
            const SizedBox(height: 25),
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
                    bgColor: white,
                    bgRadius: 15,
                    onTapColor: blue,
                    onTapRadius: 15,
                    padding: const EdgeInsets.all(2),
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
