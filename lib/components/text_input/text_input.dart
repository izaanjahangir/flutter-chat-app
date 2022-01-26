import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String placeholder;
  final bool obscureText;
  final Color? fillColor;
  final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(small_radius),
      borderSide: BorderSide.none);
  final TextEditingController controller;
  final String? errorMessage;

  TextInput(
      {required this.placeholder,
      this.obscureText = false,
      this.errorMessage,
      this.fillColor,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    Color inputFillColor = fillColor == null ? lightBlack : fillColor as Color;

    return TextFormField(
      style: TextStyle(color: white, fontSize: normal_font),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: placeholder,
          errorText: errorMessage,
          errorMaxLines: 1,
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: red)),
          errorStyle: TextStyle(color: red, fontSize: small_font),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: red)),
          hintStyle: TextStyle(color: white),
          contentPadding: const EdgeInsets.only(left: 12, bottom: 18, top: 18),
          enabledBorder: border,
          filled: true,
          fillColor: inputFillColor,
          focusedBorder: border,
          focusColor: Colors.transparent),
    );
  }
}
