import 'package:flutter/material.dart';

class FileToUpload with ChangeNotifier {
  String _file = '';
  String get file => _file;

  void updateFile(String newFile) {
    _file = newFile;
    notifyListeners();
  }
}
