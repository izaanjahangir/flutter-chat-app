import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:flutter/material.dart';

class RecipientItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark_black,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: normal_space, horizontal: medium_space),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Avatar(),
              SizedBox(
                width: normal_space,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Izaan jahangir",
                      style: TextStyle(color: white, fontSize: normal_font_big),
                    ),
                    Text(
                      "This is some dummy message for testing",
                      style: TextStyle(color: grey, fontSize: normal_font),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: small_space,
              ),
              Text(
                "5 mins",
                style: TextStyle(color: grey, fontSize: small_font),
              )
            ],
          ),
        ),
      ),
    );
  }
}
