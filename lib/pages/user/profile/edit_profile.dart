import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';

class MyeditProfile extends StatefulWidget {
  const MyeditProfile({super.key});

  @override
  State<MyeditProfile> createState() => _MyeditProfileState();
}

class _MyeditProfileState extends State<MyeditProfile> {
  File? imageFile;

  TextEditingController usernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  Future pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      imageFile = File(pickedImage!.path);
    });
  }

  void handlePressedUpdateBtn() async {
    String? docUser = AuthServices().getCurrentUserUID();

    final result = await FirestoreService().updateUser(
      docUser: docUser!,
      imgFile: imageFile,
      username: usernameController.text,
      address: addressController.text,
      phone: phoneController.text,
      birthDate: birthDateController.text,
    );

    if (result == 'true') {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Adding Updating User: $result'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: MyButtonCustom(
          onPressed: () => Navigator.pop(context),
          bgColor: Colors.transparent,
          bgRadius: 50,
          onTapColor: textGrey,
          onTapRadius: 50,
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              MyImagePicker(
                title: "Profile Picture",
                imageFile: imageFile,
                pickImage: pickImage,
              ),
              const SizedBox(height: 10),
              MyTextFieldCustom(
                controller: usernameController,
                textFieldTitle: "Username",
                hintText: 'Enter Username here',
              ),
              const SizedBox(height: 10),
              MyTextFieldCustom(
                controller: addressController,
                textFieldTitle: "Address",
                hintText: 'Enter Address here',
              ),
              const SizedBox(height: 10),
              MyTextFieldCustom(
                controller: phoneController,
                textFieldTitle: "Phone Number",
                hintText: 'Enter Phone Number here',
              ),
              const SizedBox(height: 10),
              MyTextFieldCustom(
                controller: birthDateController,
                textFieldTitle: "Birth Date",
                hintText: 'Enter Birth Date here',
              ),
              const SizedBox(height: 25),
              MyButtonCustom(
                onPressed: handlePressedUpdateBtn,
                bgColor: black,
                bgRadius: 15,
                onTapColor: textGrey,
                onTapRadius: 15,
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
