import 'package:chat_app/components/avatar/avatar.dart';
import 'package:chat_app/components/chat_bubble/chat_bubble.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/exceptions/app_exception.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String? roomId;

  final TextEditingController messageController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final UserModel otherUser = UserModel.fromMap(args["selectedUser"]);

    Future<String> createRoom() async {
      try {
        if (roomId != null) {
          return Future.value(roomId);
        }

        final UserModel currentUser =
            Provider.of<UserProvider>(context, listen: false).user as UserModel;

        CollectionReference room =
            FirebaseFirestore.instance.collection('rooms');

        DocumentReference doc = await room.add({
          "users": [currentUser.id, otherUser.id],
          "createdAt": FieldValue.serverTimestamp(),
        });
        await doc.set({"id": doc.id}, SetOptions(merge: true));
        setState(() {
          roomId = doc.id;
        });

        return doc.id;
      } on AppException catch (e) {
        throw e;
      }
    }

    Future<void> sendMessage() async {
      try {
        String message = messageController.text;

        if (message.isEmpty) {
          throw AppException("Please write some message first");
        }

        messageController.clear();

        final String roomId = await createRoom();
        final UserModel currentUser =
            Provider.of<UserProvider>(context, listen: false).user as UserModel;

        CollectionReference chats = FirebaseFirestore.instance
            .collection('rooms')
            .doc(roomId)
            .collection("chats");

        DocumentReference doc = await chats.add({
          "sender": currentUser.id,
          "receiver": otherUser.id,
          "message": message,
          "createdAt": FieldValue.serverTimestamp(),
        });
        await doc.set({"id": doc.id}, SetOptions(merge: true));
      } on AppException catch (e) {
        EasyLoading.showError(e.message);
      }
    }

    Widget getSendButton() {
      double _size = 35;
      double _iconSize = _size * 0.5;

      return ClipRRect(
        borderRadius: BorderRadius.circular(_size),
        child: GestureDetector(
          onTap: sendMessage,
          child: Container(
              color: lightBlue,
              height: _size,
              width: _size,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/send.svg",
                color: white,
                width: _iconSize,
                height: _iconSize,
              )),
        ),
      );
    }

    Widget getFooter() {
      return Container(
        width: double.infinity,
        color: darkBlack,
        padding: EdgeInsets.symmetric(horizontal: small_space * 1.1),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: small_space * 1.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 100),
                  color: lightBlack,
                  padding: EdgeInsets.symmetric(horizontal: small_space),
                  child: TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(color: white, fontSize: normal_font),
                    decoration: InputDecoration(
                        isDense: true,
                        hintStyle: TextStyle(color: white),
                        contentPadding: const EdgeInsets.only(
                            left: 0,
                            bottom: small_space,
                            top: small_space,
                            right: 0),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusColor: Colors.transparent),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                ),
              ),
              SizedBox(
                width: small_space,
              ),
              getSendButton()
            ],
          ),
        ),
      );
    }

    void goBack() {
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboardOnTap(context);
        },
        child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: normal_space),
                  color: darkBlack,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: goBack,
                        child: SvgPicture.asset(
                          "assets/icons/back-arrow.svg",
                          color: white,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      SizedBox(
                        width: small_space,
                      ),
                      Avatar(
                        size: 40,
                        url: otherUser.profileImage,
                      ),
                      SizedBox(
                        width: small_space,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            otherUser.fullName,
                            style: TextStyle(
                                color: white, fontSize: normal_font_big),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: medium_space, vertical: small_space),
                  color: lightBlack,
                  child: Column(
                    children: [
                      ChatBubble(
                        type: "sender",
                        message: "This is a message from sender xyz",
                      ),
                      ChatBubble(
                        type: "receiver",
                        message: "This is a message from receiver xyz",
                      )
                    ],
                  ),
                )),
                getFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
