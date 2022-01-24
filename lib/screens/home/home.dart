import 'package:chat_app/components/recipient_item/recipient_item.dart';
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
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: dark_black,
              padding: EdgeInsets.symmetric(horizontal: medium_space),
              child: Column(
                children: [
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                  RecipientItem(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
