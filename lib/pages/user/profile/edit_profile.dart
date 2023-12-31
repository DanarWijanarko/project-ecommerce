// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ecommerce/components/_components.dart';
import 'package:project_ecommerce/constants/color.dart';
import 'package:project_ecommerce/functions/auth_services.dart';
import 'package:project_ecommerce/functions/firestore_services.dart';
import 'package:project_ecommerce/models/user_model.dart';

class MyeditProfile extends StatefulWidget {
  const MyeditProfile({super.key});

  @override
  State<MyeditProfile> createState() => _MyeditProfileState();
}

class _MyeditProfileState extends State<MyeditProfile> {
  File? imageFile;
  String imgExist = 'null';
  String imgName = 'null';

  String? docUser = AuthServices().getCurrentUserUID();

  TextEditingController usernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    handleDefaultDataUser();
  }

  void handleDefaultDataUser() async {
    User? user = await FirestoreService().getCurrentUserData(docUser);

    setState(() {
      imgExist = user?.imgUrl == 'null' ? 'null' : user!.imgUrl;
      imgName = user?.imgName == 'null' ? 'null' : user!.imgName;
      usernameController.text = user?.username == 'null' ? '' : user!.username;
      addressController.text = user?.address == 'null' ? '' : user!.address;
      phoneController.text = user?.phone == 'null' ? '' : user!.phone;
      birthDateController.text =
          user?.birthDate == 'null' ? '' : user!.birthDate;
    });
  }

  Future pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      imageFile = File(pickedImage!.path);
    });
  }

  void handlePressedUpdateBtn() async {
    final result = await FirestoreService().updateUser(
      docUser: docUser!,
      imgFile: imageFile,
      imgUrl: imgExist,
      imgName: imgName,
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
        toolbarHeight: 75,
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
                imageExist: imgExist,
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
