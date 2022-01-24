import 'package:chat_app/config/theme_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenderInputItem extends StatelessWidget {
  final String type;

  GenderInputItem({required this.type});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        color: Colors.white,
        width: 50,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: small_space),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (type == "male")
              SvgPicture.asset(
                "assets/icons/male.svg",
                width: 25,
                height: 25,
              ),
            if (type == "female")
              SvgPicture.asset(
                "assets/icons/female.svg",
                width: 25,
                height: 25,
              ),
          ],
        ),
      ),
    );
  }
}
