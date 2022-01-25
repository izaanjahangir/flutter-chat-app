import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/components/chat_bubble/chat_bubble.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Chat extends StatelessWidget {
  final TextEditingController messageController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Widget getSendButton() {
      double _size = 35;
      double _iconSize = _size * 0.5;

      return ClipRRect(
        borderRadius: BorderRadius.circular(_size),
        child: GestureDetector(
          child: Container(
              color: lightBlue,
              height: _size,
              width: _size,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/send.svg",
                color: white,
                width: _iconSize,
                height: _iconSize,
              )),
        ),
      );
    }

    Widget getFooter() {
      return Container(
        width: double.infinity,
        color: darkBlack,
        padding: EdgeInsets.symmetric(horizontal: small_space * 1.1),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: small_space * 1.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 100),
                  color: lightBlack,
                  padding: EdgeInsets.symmetric(horizontal: small_space),
                  child: TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(color: white, fontSize: normal_font),
                    decoration: InputDecoration(
                        isDense: true,
                        hintStyle: TextStyle(color: white),
                        contentPadding: const EdgeInsets.only(
                            left: 0,
                            bottom: small_space,
                            top: small_space,
                            right: 0),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusColor: Colors.transparent),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                ),
              ),
              SizedBox(
                width: small_space,
              ),
              getSendButton()
            ],
          ),
        ),
      );
    }

    void goBack() {
      Navigator.of(context).pop();
    }

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
                  height: 60,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: normal_space),
                  color: darkBlack,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: goBack,
                        child: SvgPicture.asset(
                          "assets/icons/back-arrow.svg",
                          color: white,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      SizedBox(
                        width: small_space,
                      ),
                      Avatar(
                        size: 40,
                      ),
                      SizedBox(
                        width: small_space,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Izaan jahangir",
                            style: TextStyle(
                                color: white, fontSize: normal_font_big),
                          )
                        ],
                      )
                    ],
                  ),
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
                getFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
