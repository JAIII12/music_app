import 'package:flutter/material.dart';
import 'package:music_app/themes/darkmode.dart';
import 'package:music_app/themes/lightmode.dart';

class ThemeProvider extends ChangeNotifier {
  //initially, light mode
  ThemeData _themeData = lightMode;

  //get theme 
  ThemeData get themeData => _themeData;

  //is dark mode
  bool get isDarkMode => _themeData == darkmode;

  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    //update ui
    notifyListeners();
  }

  //toggle theme
  void toggleTheme(){
    if (_themeData == lightMode) {
      themeData = darkmode;
    } else {
      themeData = lightMode;
    }
  }
}
