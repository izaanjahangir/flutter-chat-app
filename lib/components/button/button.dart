import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function onTap;

  Button({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(small_radius),
      child: Material(
        color: lightBlue,
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            width: double.infinity,
            height: 45,
            child: Center(
                child: Text(
              label,
              style: TextStyle(color: white, fontSize: normal_font),
            )),
          ),
        ),
      ),
    );
  }
}
