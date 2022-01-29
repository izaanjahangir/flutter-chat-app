import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/components/button/button.dart';
import 'package:chat_app/components/gender_input/gender_input.dart';
import 'package:chat_app/components/text_input/text_input.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/exceptions/app_exception.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? selectedGender;
  String? profileImage;
  UserModel? user;

  // ignore: non_constant_identifier_names
  final Seperator = SizedBox(
    height: medium_space,
  );

  @override
  void initState() {
    super.initState();

    user = Provider.of<UserProvider>(context, listen: false).user;

    firstNameController.text = user!.firstName;
    lastNameController.text = user!.lastName;
    emailController.text = user!.email;
    selectedGender = user!.gender;
    profileImage = user!.profileImage;
  }

  @override
  Widget build(BuildContext context) {
    void handleAvatarSelect(XFile image) {
      print(image.path);

      setState(() {
        profileImage = image.path;
      });
    }

    void goBack() {
      Navigator.of(context).pop();
    }

    Future<void> saveProfile() async {
      try {
        Helpers.closeKeyboard();
        EasyLoading.show(status: 'loading...');

        Map<String, dynamic> newUser = {
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "gender": selectedGender
        };

        if (!profileImage!.startsWith("http")) {
          File imageFile = File(profileImage as String);
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('uploads/${Uuid().v4()}.png');
          await ref.putFile(imageFile);
          String downloadUrl = await ref.getDownloadURL();
          newUser["profileImage"] = downloadUrl;
        }

        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        await users.doc(user!.id).set(newUser, SetOptions(merge: true));

        Provider.of<UserProvider>(context, listen: false).updateUser(newUser);
        EasyLoading.showSuccess('Successful');
        Navigator.of(context).pop();
      } on FirebaseException catch (e) {
        EasyLoading.showError(e.message as String);
      } on AppException catch (e) {
        EasyLoading.showError(e.message);
      }

      EasyLoading.dismiss();
    }

    Future<void> logout() async {
      try {
        EasyLoading.show(status: 'loading...');

        await FirebaseAuth.instance.signOut();
        Provider.of<UserProvider>(context, listen: false).resetUser();

        EasyLoading.showSuccess('Successful');
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      } on FirebaseAuthException catch (e) {
        EasyLoading.showError(e.message as String);
      } on AppException catch (e) {
        EasyLoading.showError(e.message);
      }

      EasyLoading.dismiss();
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: darkBlack,
            height: 50,
            child: Stack(
              children: [
                Center(
                    child: Text(
                  "Profile",
                  style: TextStyle(fontSize: normal_font_big, color: white),
                )),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: goBack,
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontSize: normal_font_big, color: lightBlue),
                        )))
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: lightBlack,
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: medium_space, horizontal: medium_space),
                  child: Column(
                    children: [
                      Avatar(
                        size: 120,
                        url: profileImage,
                        onImageSelect: handleAvatarSelect,
                      ),
                      Seperator,
                      TextInput(
                          placeholder: "Enter your first name",
                          fillColor: darkBlack,
                          controller: firstNameController),
                      Seperator,
                      TextInput(
                        placeholder: "Enter your last name",
                        fillColor: darkBlack,
                        controller: lastNameController,
                      ),
                      Seperator,
                      TextInput(
                        placeholder: "Enter your email",
                        fillColor: darkBlack,
                        controller: emailController,
                      ),
                      Seperator,
                      GenderInput(
                        initialGender: selectedGender,
                        onGenderSelect: (newGender) {
                          setState(() {
                            selectedGender = newGender;
                          });
                        },
                      ),
                      Seperator,
                      Button(
                        label: "Save Profile",
                        onTap: saveProfile,
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
                        onTap: logout,
                        theme: "danger",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
