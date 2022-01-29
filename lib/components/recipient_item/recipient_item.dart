import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

class RecipientItem extends StatelessWidget {
  final Function onTap;
  final UserModel user;
  final MessageModel? message;

  RecipientItem({required this.onTap, required this.user, this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: darkBlack,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: normal_space, horizontal: medium_space),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Avatar(
                url: user.profileImage,
              ),
              SizedBox(
                width: normal_space,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: TextStyle(color: white, fontSize: normal_font_big),
                    ),
                    Text(
                      message != null ? message!.text : "Start a conversation",
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
