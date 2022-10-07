import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';

import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode

class Theme with ChangeNotifier {
  Future<ThemeData> loadTheme() async {
    final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
    final themeJson = jsonDecode(themeStr);
    final theme = ThemeDecoder.decodeThemeData(themeJson)!;
    return theme;
  }

  get theme => loadTheme();
}
