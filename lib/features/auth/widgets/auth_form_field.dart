import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Pallete.blueColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Pallete.greyColor),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}
