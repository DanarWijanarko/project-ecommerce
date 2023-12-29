// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_ecommerce/constants/color.dart';

class MyButtonCustom extends StatelessWidget {
  MyButtonCustom({
    super.key,
    required this.onPressed,
    required this.bgColor,
    required this.bgRadius,
    required this.onTapColor,
    required this.onTapRadius,
    required this.padding,
    this.onTapPadding = const EdgeInsets.all(0),
    this.width,
    this.height,
    this.border = false,
    this.borderColor = Colors.white,
    required this.child,
  });

  final Color onTapColor, bgColor, borderColor;
  final VoidCallback onPressed;
  final double onTapRadius, bgRadius;
  final EdgeInsetsGeometry padding, onTapPadding;
  final Widget child;
  double? width, height;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: onTapPadding,
        minimumSize: Size.zero,
        foregroundColor: onTapColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(onTapRadius),
          side: (border)
              ? BorderSide(
                  color: borderColor,
                  width: 2.5,
                )
              : BorderSide.none,
        ),
      ),
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(bgRadius),
        ),
        child: child,
      ),
    );
  }
}

class MyNavbarButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final int? selectedIndex, index;

  const MyNavbarButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.selectedIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == index) {
      return InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.only(right: 9),
          decoration: BoxDecoration(
            color: bgActiveNavbar,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: white,
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(5),
          minimumSize: Size.zero,
          foregroundColor: textGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(55),
          ),
        ),
        child: Icon(
          icon,
          color: black,
          size: 25,
        ),
      );
    }
  }
}
