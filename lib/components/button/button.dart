import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;

  Button({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(small_radius),
      child: Material(
        color: light_blue,
        child: InkWell(
          onTap: () {},
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
