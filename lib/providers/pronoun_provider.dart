import 'package:flutter/material.dart';

class SelectedPronoun with ChangeNotifier {
  String _pronoun = 'he/him';
  String get pronoun => _pronoun;

  void updatePronoun(String newPronoun) {
    _pronoun = newPronoun;
    notifyListeners();
  }
}
