import 'package:chat_app/models/user_model.dart';

class MessageModel {
  late UserModel user;
  late String message, timestamp;

  MessageModel({
    required this.user,
    required this.message,
    required this.timestamp,
  });
}
