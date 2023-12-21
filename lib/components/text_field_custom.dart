// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/_components.dart';

class MyTextFieldCustom extends StatelessWidget {
  MyTextFieldCustom({
    super.key,
    this.controller,
    required this.textFieldTitle,
    this.hintText,
    this.hintField = '',
    this.readOnly = false,
    this.validator,
  });

  TextEditingController? controller;
  final String textFieldTitle;
  String? hintText;
  String hintField;
  bool readOnly;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              textFieldTitle,
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            if (hintField != '')
              Text(
                hintField,
                style: TextStyle(
                  color: red,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          obscureText: false,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 18,
            ),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: blue, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blue, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blue, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: red, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            errorStyle: TextStyle(
              color: red,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class MyAuthTextField extends StatelessWidget {
  const MyAuthTextField({
    super.key,
    required this.labelText,
    required this.icon,
    this.controller,
  });

  final String labelText;
  final IconData icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          icon,
          size: 31,
          color: textGrey.withAlpha(150),
        ),
        labelStyle: TextStyle(
          color: textGrey.withAlpha(150),
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: blue, width: 2.0),
          borderRadius: BorderRadius.circular(13),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: blue, width: 1.0),
          borderRadius: BorderRadius.circular(13),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: blue, width: 2.2),
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }
}
