import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  var text = "";
  var selectedIndex = 0;

  void setText(String newtext) {
    text = newtext;
    notifyListeners();
  }

  void setSelectedThemeIndex(int newInt) {
    selectedIndex = newInt;
    notifyListeners();
  }
}
