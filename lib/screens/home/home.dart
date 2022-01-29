import 'dart:async';

import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/components/recipient_item/recipient_item.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/screens/profile/profile.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> conversations = [];
  List<dynamic> newUsers = [];
  StreamSubscription<dynamic>? chatSubscription;

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
    EasyLoading.show(status: 'loading...');

    Stream collectionStream = FirebaseFirestore.instance
        .collection('users')
        .where("id",
            isNotEqualTo:
                Provider.of<UserProvider>(context, listen: false).user!.id)
        .snapshots();

    if (chatSubscription != null) {
      chatSubscription!.cancel();
    }

    chatSubscription = collectionStream.listen((event) async {
      List<Future> futures = [];

      event.docs.forEach((doc) {
        futures.add(fetchLastMessage(doc.data()));
      });

      // List<Map<String, dynamic>> data = Future.;
      List<dynamic> data = await Future.wait(futures);
      final List<dynamic> conversationList = [];
      final List<dynamic> newUsersList = [];

      data.forEach((item) {
        if (item["lastMessage"] != null) {
          conversationList.add(item);
        } else {
          newUsersList.add(item);
        }
      });

      setState(() {
        conversations = conversationList;
        newUsers = newUsersList;
      });
      EasyLoading.dismiss();
    });
  }

  Future<Map<String, dynamic>?> fetchLastMessage(
      Map<String, dynamic> data) async {
    try {
      final UserModel currentUser =
          Provider.of<UserProvider>(context, listen: false).user as UserModel;
      final CollectionReference roomsCollection =
          FirebaseFirestore.instance.collection('rooms');
      final QuerySnapshot rooms = await roomsCollection
          .where("users.${currentUser.id}", isEqualTo: true)
          .where("users.${data["id"]}", isEqualTo: true)
          .limit(1)
          .get();

      print("size " + rooms.size.toString());

      if (rooms.size > 0) {
        final String roomId = rooms.docs[0].id;
        final CollectionReference chatCollection = FirebaseFirestore.instance
            .collection('rooms')
            .doc(roomId)
            .collection("chats");
        final QuerySnapshot messages = await chatCollection
            .orderBy("createdAt", descending: true)
            .limit(1)
            .get();
        final Map<String, dynamic>? lastMessage = (messages.size > 0
            ? messages.docs[0].data()
            : null) as Map<String, dynamic>?;
        return {"user": data, "lastMessage": lastMessage, "roomId": roomId};
      }

      return {"user": data};
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    super.dispose();

    chatSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> goToChat(Map<String, dynamic> selectedUser) async {
      Map<String, dynamic> arguments = {
        "selectedUser": selectedUser["user"],
        "roomId": selectedUser["roomId"]
      };

      await Navigator.of(context).pushNamed("/chat", arguments: arguments);

      fetchData();
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
                                user: UserModel.fromMap(item["user"])),
                          getSeperator("New Users"),
                          for (var item in newUsers)
                            RecipientItem(
                                onTap: () {
                                  goToChat(item);
                                },
                                user: UserModel.fromMap(item["user"])),
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
