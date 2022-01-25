import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/components/button/button.dart';
import 'package:chat_app/components/gender_input/gender_input.dart';
import 'package:chat_app/components/text_input/text_input.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final Seperator = SizedBox(
    height: medium_space,
  );

  @override
  Widget build(BuildContext context) {
    void handleAvatarSelect() {}

    return Scaffold(
      body: Container(
        color: lightBlack,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: medium_space, horizontal: medium_space),
        child: Column(
          children: [
            Avatar(
              size: 120,
              onImageSelect: handleAvatarSelect,
            ),
            Seperator,
            TextInput(
              placeholder: "Enter your first name",
              fillColor: darkBlack,
            ),
            Seperator,
            TextInput(
              placeholder: "Enter your last name",
              fillColor: darkBlack,
            ),
            Seperator,
            TextInput(
              placeholder: "Enter your email",
              fillColor: darkBlack,
            ),
            Seperator,
            GenderInput(),
            Seperator,
            Button(
              label: "Save Profile",
              onTap: () {},
            ),
            Seperator,
            Divider(
              color: white,
              indent: MediaQuery.of(context).size.width * 0.25,
              endIndent: MediaQuery.of(context).size.width * 0.25,
            ),
            Seperator,
            Button(
              label: "Logout",
              onTap: () {},
              theme: "danger",
            ),
          ],
        ),
      ),
    );
  }
}
