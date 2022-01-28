import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

    _user = UserModel(
        firstName: userData["firstName"],
        lastName: userData["lastName"],
        email: userData["email"],
        gender: userData["gender"],
        profileImage: userData["profileImage"],
        id: snapshot.id);

    notifyListeners();
  }

  void updateUser(Map userData) {
    _user = UserModel(
        firstName: userData["firstName"] ?? _user!.firstName,
        gender: userData["gender"] ?? _user!.gender,
        lastName: userData["lastName"] ?? user!.lastName,
        profileImage: userData["profileImage"] ?? user!.profileImage,
        email: _user!.email,
        id: _user!.id);
    notifyListeners();
  }

  void resetUser() {
    _user = null;
  }
}
