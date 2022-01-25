import 'package:chat_app/components/chat_bubble/chat_bubble.dart';
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
                  color: darkBlack,
                ),
                Expanded(
                    child: Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: medium_space, vertical: small_space),
                  color: lightBlack,
                  child: Column(
                    children: [
                      ChatBubble(
                        type: "sender",
                        message: "This is a message from sender xyz",
                      ),
                      ChatBubble(
                        type: "receiver",
                        message: "This is a message from receiver xyz",
                      )
                    ],
                  ),
                )),
                Container(
                  height: 70,
                  width: double.infinity,
                  color: darkBlack,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
