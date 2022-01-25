import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboardOnTap(context);
        },
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  color: dark_black,
                ),
                Expanded(
                    child: Container(
                  height: 100,
                  width: double.infinity,
                  color: light_black,
                )),
                Container(
                  height: 70,
                  width: double.infinity,
                  color: dark_black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
