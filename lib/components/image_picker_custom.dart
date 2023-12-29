// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/button_custom.dart';
import 'package:project_ecommerce/constants/color.dart';

class MyImagePicker extends StatelessWidget {
  MyImagePicker({
    super.key,
    required this.title,
    required this.imageFile,
    required this.pickImage,
  });

  String title;
  File? imageFile;
  VoidCallback pickImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: BoxDecoration(
            color: bgGrey,
            border: Border.all(
              color: textGrey.withOpacity(0.5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: (imageFile == null)
              ? MyButtonCustom(
                  onPressed: pickImage,
                  bgColor: Colors.transparent,
                  bgRadius: 20,
                  onTapColor: textGrey,
                  onTapRadius: 20,
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          color: textGrey.withOpacity(0.5),
                        ),
                        Text(
                          "Add Picture",
                          style: TextStyle(
                            color: textGrey.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: FileImage(File(imageFile!.path)),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}