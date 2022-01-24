import 'package:chat_app/components/button/button.dart';
import 'package:chat_app/components/gender_input/gender_input.dart';
import 'package:chat_app/components/text_input/text_input.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/theme_colors.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget renderForm() {
      return Form(
          key: _registerFormKey,
          child: Column(
            children: [
              TextInput(placeholder: "Enter your first name"),
              SizedBox(
                height: medium_space,
              ),
              TextInput(placeholder: "Enter your last name"),
              SizedBox(
                height: medium_space,
              ),
              GenderInput(),
              SizedBox(
                height: medium_space,
              ),
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
              TextInput(
                placeholder: "Confirm your password",
                obscureText: true,
              ),
              SizedBox(
                height: medium_space,
              ),
              Button(label: "Register")
            ],
          ));
    }

    Widget renderFooter() {
      return Container(
        height: 60,
        width: double.infinity,
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already a user?",
              style: TextStyle(color: light_black, fontSize: normal_font),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text("Login here",
                  style: TextStyle(color: light_black, fontSize: normal_font)),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboardOnTap(context);
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            color: dark_black,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      primary: false,
                      child: Padding(
                        padding: const EdgeInsets.all(medium_space),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Register here",
                              style: TextStyle(
                                  color: white, fontSize: medium_font),
                            ),
                            SizedBox(
                              height: medium_space,
                            ),
                            renderForm(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                renderFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
