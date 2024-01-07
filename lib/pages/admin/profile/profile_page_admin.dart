import 'package:flutter/material.dart';

class MyProfilePageAdmin extends StatefulWidget {
  const MyProfilePageAdmin({super.key});

  @override
  State<MyProfilePageAdmin> createState() => _MyProfilePageAdminState();
}

class _MyProfilePageAdminState extends State<MyProfilePageAdmin> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile Admin"));
  }
}
