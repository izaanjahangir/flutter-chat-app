import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboardOnTap(context);
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            color: dark_black,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: medium_space),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Home here",
                        style: TextStyle(color: white, fontSize: medium_font),
                      ),
                      SizedBox(
                        height: medium_space,
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
