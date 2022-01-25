import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/components/recipient_item/recipient_item.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Widget getSeperator(String label) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: small_space),
      margin: EdgeInsets.only(
          left: medium_space,
          right: medium_space,
          bottom: normal_space,
          top: small_space),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: grey, width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: white, fontSize: normal_font_big),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void goToChat() {
      Navigator.of(context).pushNamed("/chat");
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboardOnTap(context);
        },
        child: Scaffold(
          body: Container(
            color: darkBlack,
            padding: EdgeInsets.symmetric(vertical: normal_space),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: medium_space),
                    child: Avatar(),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getSeperator("Conversation"),
                          RecipientItem(
                            onTap: goToChat,
                          ),
                          getSeperator("New Users"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
