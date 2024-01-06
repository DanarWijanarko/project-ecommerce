import 'package:flutter/material.dart';

export 'appbar_custom.dart';
export 'button_custom.dart';
export 'cart_view.dart';
export 'image_picker_custom.dart';
export 'product_view.dart';
export 'profile_information.dart';
export 'text_field_custom.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey[400],
      margin: const EdgeInsets.only(top: 5, bottom: 4),
    );
  }
}
