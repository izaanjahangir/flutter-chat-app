import 'package:chat_app/config/theme_colors.dart';
import 'package:flutter/material.dart';

class ChatBubbleCustomShape extends CustomPainter {
  final String type;

  ChatBubbleCustomShape({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = type == "receiver" ? lightGrey : lightBlue;
    Path path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
