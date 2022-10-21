import 'package:flutter/material.dart';

class StepNumber with ChangeNotifier {
  int _step = 1;
  int get step => _step;

  void nextStep() {
    _step++;
    notifyListeners();
  }
}
