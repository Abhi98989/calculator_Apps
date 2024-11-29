import 'package:calculator_app/drawer/about%20us/aboutus_screen.dart';
import 'package:calculator_app/drawer/privacy%20policy/privacypolicy_screen.dart';
import 'package:calculator_app/scientific/second_screen.dart';
import 'package:calculator_app/screen/calculatorScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:calculator_app/drawer/setting/setting_screen.dart';
List<String> calculationHistory = []; // Global history list

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return CalculatorScreen(toggleTheme: toggleTheme);
          },
        ),
        // GoRoute(
        //   path: '/ProfileScreen',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const ProfileScreen();
        //   },
        // ),
        // GoRoute(
        //   path: '/StorageScreen',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return StorageScreen(calculationHistory: calculationHistory);
        //   },
        // ),
        GoRoute(
          path: '/ModeScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const ModeScreen();
          },
        ),
        GoRoute(
          path: '/AboutUsPageScreen',
          builder: (BuildContext context, GoRouterState state) {
            return AboutUsPageScreen();
          },
        ),
        GoRoute(
          path: '/PrivacyPolicyScreen',
          builder: (BuildContext context, GoRouterState state) {
            return PrivacyPolicyScreen();
          },
        ),
        GoRoute(
          path: '/CalculatorApp',
          builder: (BuildContext context, GoRouterState state) {
            return CalculatorApp(toggleTheme: toggleTheme);
          },
        ),
      ],
    );
    
    return MaterialApp.router(
      title: 'Calculator App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
