import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInformation with ChangeNotifier {
  String? _name;
  String? _email;
  String? _uid;
  String? _photoUrl;

  String? get photoUrl => _photoUrl;
  String? get name => _name;
  String? get email => _email;
  String? get uid => _uid;

  Future updateUserInfo(User user) async {
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

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    notifyListeners();
    // });
  }
}
