import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/components/recipient_item/recipient_item.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/screens/profile/profile.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> conversations = [];

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
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() {
    Stream collectionStream = FirebaseFirestore.instance
        .collection('users')
        .where("id",
            isNotEqualTo:
                Provider.of<UserProvider>(context, listen: false).user!.id)
        .snapshots();
    collectionStream.listen((event) {
      List<Map<String, dynamic>> data = [];

      event.docs.forEach((doc) {
        data.add(doc.data());
      });

      setState(() {
        conversations = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void goToChat(Map<String, dynamic> selectedUser) {
      Map<String, dynamic> arguments = {"selectedUser": selectedUser};

      Navigator.of(context).pushNamed("/chat", arguments: arguments);
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
                HomeHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getSeperator("Conversation"),
                          for (var item in conversations)
                            RecipientItem(
                                onTap: () {
                                  goToChat(item);
                                },
                                user: UserModel.fromMap(item)),
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

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void openProfileSheet() {
      showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => Profile(),
          enableDrag: false,
          expand: false,
          duration: Duration(milliseconds: 300));
    }

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: medium_space),
        child: Avatar(
          url: Provider.of<UserProvider>(context).user!.profileImage,
          onTap: openProfileSheet,
        ),
      ),
    );
  }
}
