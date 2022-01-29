import 'package:chat_app/components/button/button.dart';
import 'package:chat_app/components/text_input/text_input.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/exceptions/app_exception.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  Map<String, String> errors = {};

  @override
  Widget build(BuildContext context) {
    void validateFields() {
      Map<String, String> localErrors = {};

      if (emailController.text.isEmpty) {
        localErrors["email"] = "This field is required";
      }
      if (passwordController.text.isEmpty) {
        localErrors["password"] = "This field is required";
      }

      setState(() {
        errors = localErrors;
      });

      if (localErrors.length > 0) {
        throw AppException("Validation errors");
      }
    }

    Future<void> login() async {
      try {
        Helpers.closeKeyboard();
        EasyLoading.show(status: 'loading...');
        validateFields();

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        DocumentSnapshot<Object?> user =
            await users.doc(userCredential.user?.uid).get();

        EasyLoading.showSuccess('Successful');

        Provider.of<UserProvider>(context, listen: false).setUser(user);

        emailController.clear();
        passwordController.clear();
        Navigator.of(context).pushNamed("/home");
      } on FirebaseAuthException catch (e) {
        EasyLoading.showError(e.message as String);
      } on AppException catch (e) {
        EasyLoading.showError(e.message);
      }

      EasyLoading.dismiss();
    }

    Widget renderForm() {
      return Form(
          key: _formKey,
          child: Column(
            children: [
              TextInput(
                placeholder: "Enter your email",
                controller: emailController,
                errorMessage: errors["email"],
              ),
              SizedBox(
                height: medium_space,
              ),
              TextInput(
                placeholder: "Enter your password",
                obscureText: true,
                controller: passwordController,
                errorMessage: errors["password"],
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
