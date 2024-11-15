// main.dart
import 'package:calculator_app/screen/calculatorScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Default theme is light

  // Toggle between light and dark mode
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData.light(), // Light mode theme
      darkTheme: ThemeData.dark(), // Dark mode theme
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Set the theme mode
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(toggleTheme: toggleTheme), // Pass the toggleTheme to CalculatorScreen
    );
  }
}
