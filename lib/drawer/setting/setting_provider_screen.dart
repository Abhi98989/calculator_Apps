import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _scientificMode = false;
  double _fontSize = 14;

  bool get isDarkMode => _isDarkMode;
  bool get scientificMode => _scientificMode;
  double get fontSize => _fontSize;

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();  // Notifies listeners of the change
  }

  void toggleScientificMode(bool value) {
    _scientificMode = value;
    notifyListeners();  // Notifies listeners of the change
  }

  void setFontSize(double value) {
    _fontSize = value;
    notifyListeners();  // Notifies listeners of the change
  }

  void resetSettings() {
    _isDarkMode = false;
    _scientificMode = false;
    _fontSize = 14;
    notifyListeners();  // Notifies listeners of the reset
  }
}
