import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  String? _name;
  String? _email;
  String? _uid;
  String? _photoUrl;

  String? get photoUrl => _photoUrl;
  String? get name => _name;
  String? get email => _email;
  String? get uid => _uid;

  void updateUserInfo(User user) {
    if (user.displayName != null) {
      _name = user.displayName;
    } else {
      _name = 'User';
    }

    if (user.photoURL != null) {
      _photoUrl = user.photoURL;
    } else {
      _photoUrl = 'https://via.placeholder.com/150';
    }
    _email = user.email;
    _uid = user.uid;
    notifyListeners();
  }
}
