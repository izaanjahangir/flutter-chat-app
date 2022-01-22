import 'package:chat_app/components/button/button.dart';
import 'package:chat_app/components/text_input/text_input.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/theme_colors.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboardOnTap(context);
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: medium_space),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login here",
                  style: TextStyle(color: white, fontSize: medium_font),
                ),
                SizedBox(
                  height: medium_space,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextInput(placeholder: "Enter your email"),
                        SizedBox(
                          height: medium_space,
                        ),
                        TextInput(
                          placeholder: "Enter your password",
                          obscureText: true,
                        ),
                        SizedBox(
                          height: medium_space,
                        ),
                        Button(label: "Login")
                      ],
                    ))
              ],
            ),
            color: dark_black,
          ),
        ),
      ),
    );
  }
}
