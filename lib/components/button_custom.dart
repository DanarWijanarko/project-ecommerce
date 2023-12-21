// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

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
    required this.child,
  });

  final Color onTapColor, bgColor;
  final VoidCallback onPressed;
  final double onTapRadius, bgRadius;
  final EdgeInsetsGeometry padding, onTapPadding;
  final Widget child;
  double? width, height;

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
