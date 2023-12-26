import 'package:flutter/material.dart';
import 'package:project_ecommerce/components/_components.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 45,
      flexibleSpace: SafeArea(
        child: Row(
          children: [
            const SizedBox(width: 21),
            MyButtonCustom(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              bgColor: Colors.transparent,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
