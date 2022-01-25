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

  TextInput(
      {required this.placeholder, this.obscureText = false, this.fillColor});

  @override
  Widget build(BuildContext context) {
    Color inputFillColor = fillColor == null ? lightBlack : fillColor as Color;

    return TextFormField(
      style: TextStyle(color: white, fontSize: normal_font),
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: white),
          contentPadding: const EdgeInsets.only(left: 12, bottom: 18, top: 18),
          enabledBorder: border,
          filled: true,
          fillColor: inputFillColor,
          focusedBorder: border,
          focusColor: Colors.transparent),
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }
}
