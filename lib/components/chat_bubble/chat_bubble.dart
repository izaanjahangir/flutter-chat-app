import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/components/chat_bubble/custom_shape.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String type;
  final String message;

  ChatBubble({required this.type, required this.message});

  @override
  Widget build(BuildContext context) {
    BorderRadius? borderRadius;

    if (type == "receiver") {
      borderRadius = BorderRadius.only(
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      );
    }

    if (type == "sender") {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: small_space),
      child: Row(
        mainAxisAlignment: type == "receiver"
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (type == "receiver")
            CustomPaint(
              painter: ChatBubbleCustomShape(type: type),
            ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: normal_space, vertical: normal_space),
              decoration: BoxDecoration(
                color: type == "receiver" ? lightGrey : lightBlue,
                borderRadius: borderRadius,
              ),
              child: Text(
                message,
                style: TextStyle(
                    color: type == "receiver" ? black : white,
                    fontSize: normal_font),
              ),
            ),
          ),
          if (type == "sender")
            CustomPaint(
              painter: ChatBubbleCustomShape(type: type),
            ),
        ],
      ),
    );
  }
}
