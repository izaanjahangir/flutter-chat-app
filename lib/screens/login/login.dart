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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login() {
      Navigator.of(context).pushNamed("/home");
    }

    Widget renderForm() {
      return Form(
          key: _formKey,
          child: Column(
            children: [
              TextInput(
                placeholder: "Enter your email",
                controller: emailController,
              ),
              SizedBox(
                height: medium_space,
              ),
              TextInput(
                placeholder: "Enter your password",
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox(
                height: medium_space,
              ),
              Button(
                label: "Login",
                onTap: login,
              )
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
              "Don't have an account yet?",
              style: TextStyle(color: lightBlack, fontSize: normal_font),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/register");
              },
              child: Text("Register now",
                  style: TextStyle(color: lightBlack, fontSize: normal_font)),
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
            color: darkBlack,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
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
                      renderForm(),
                    ],
                  ),
                )),
                renderFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
