import 'package:chat_app/components/button/button.dart';
import 'package:chat_app/components/gender_input/gender_input.dart';
import 'package:chat_app/components/text_input/text_input.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/exceptions/app_exception.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Map<String, String> errors = {};
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    void validateFields() {
      Map<String, String> localErrors = {};

      if (firstNameController.text.isEmpty) {
        localErrors["firstName"] = "This field is required";
      }
      if (lastNameController.text.isEmpty) {
        localErrors["lastName"] = "This field is required";
      }
      if (emailController.text.isEmpty) {
        localErrors["email"] = "This field is required";
      }
      if (passwordController.text.isEmpty) {
        localErrors["password"] = "This field is required";
      }
      if (confirmPasswordController.text.isEmpty) {
        localErrors["password2"] = "This field is required";
      }

      if (passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty) {
        if (passwordController.text != confirmPasswordController.text) {
          localErrors["password"] = "Both passwords should match";
          localErrors["password2"] = "Both passwords should match";
        }
      }

      setState(() {
        errors = localErrors;
      });

      if (localErrors.length > 0) {
        throw AppException("Validation errors");
      }
    }

    Future<void> register() async {
      try {
        Helpers.closeKeyboard();
        EasyLoading.show(status: 'loading...');
        validateFields();

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        await users.doc(userCredential.user?.uid).set({
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "gender": selectedGender,
          "email": emailController.text
        });

        EasyLoading.showSuccess('Successful');
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        EasyLoading.showError(e.message as String);
      } on AppException catch (e) {
        EasyLoading.showError(e.message);
      }

      EasyLoading.dismiss();
    }

    void handleGenderSelect(String newGender) {
      setState(() {
        selectedGender = newGender;
      });
    }

    Widget renderForm() {
      return Form(
          key: _registerFormKey,
          child: Column(
            children: [
              TextInput(
                placeholder: "Enter your first name",
                controller: firstNameController,
                errorMessage: errors["firstName"],
              ),
              SizedBox(
                height: medium_space,
              ),
              TextInput(
                placeholder: "Enter your last name",
                controller: lastNameController,
                errorMessage: errors["lastName"],
              ),
              SizedBox(
                height: medium_space,
              ),
              GenderInput(
                onGenderSelect: handleGenderSelect,
              ),
              SizedBox(
                height: medium_space,
              ),
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
              TextInput(
                placeholder: "Confirm your password",
                obscureText: true,
                controller: confirmPasswordController,
                errorMessage: errors["password2"],
              ),
              SizedBox(
                height: medium_space,
              ),
              Button(
                label: "Register",
                onTap: register,
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
              "Already a user?",
              style: TextStyle(color: lightBlack, fontSize: normal_font),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text("Login here",
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
