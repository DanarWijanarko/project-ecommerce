// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_ecommerce/constants/color.dart';
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
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  TextEditingController? controller;
  final String textFieldTitle;
  String? hintText;
  String hintField;
  bool readOnly;
  String? Function(String?)? validator;
  int? maxLines;
  TextInputType? keyboardType;

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
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 13,
            ),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: textGrey, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textGrey, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textGrey, width: 2.0),
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

class MyAuthTextField extends StatefulWidget {
  MyAuthTextField({
    super.key,
    required this.labelText,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.isPassword = false,
  });

  final String labelText;
  final IconData icon;
  final TextEditingController? controller;
  final bool isPassword;
  bool obscureText;

  @override
  State<MyAuthTextField> createState() => _MyAuthTextFieldState();
}

class _MyAuthTextFieldState extends State<MyAuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.icon,
          size: 31,
          color: textGrey.withAlpha(150),
        ),
        suffixIcon: (widget.isPassword)
            ? MyButtonCustom(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                bgColor: Colors.transparent,
                bgRadius: 50,
                onTapColor: bgActiveNavbar,
                onTapRadius: 50,
                padding: const EdgeInsets.all(0),
                width: 30,
                height: 30,
                child: Icon(
                  (widget.obscureText)
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: textGrey,
                  size: 20,
                ),
              )
            : null,
        labelStyle: TextStyle(
          color: textGrey.withAlpha(150),
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: textGrey, width: 2.0),
          borderRadius: BorderRadius.circular(13),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textGrey, width: 1.0),
          borderRadius: BorderRadius.circular(13),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: black, width: 1.7),
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }
}

class MySearchTextField extends StatelessWidget {
  MySearchTextField({
    super.key,
    required this.searchController,
    required this.searchButton,
  });

  VoidCallback searchButton;
  TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgGrey,
        borderRadius: BorderRadius.circular(45),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 15),
            child: MyButtonCustom(
              onPressed: searchButton,
              bgColor: Colors.transparent,
              bgRadius: 50,
              onTapColor: textGrey,
              onTapRadius: 50,
              padding: const EdgeInsets.all(5),
              width: 50,
              height: 33,
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                colorFilter: ColorFilter.mode(black, BlendMode.srcIn),
              ),
            ),
          ),
          hintText: "Search here...",
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: bgGrey),
            borderRadius: BorderRadius.circular(45),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: bgGrey),
            borderRadius: BorderRadius.circular(45),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: black),
            borderRadius: BorderRadius.circular(45),
          ),
        ),
      ),
    );
  }
}
