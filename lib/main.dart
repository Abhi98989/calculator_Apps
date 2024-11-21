import 'package:calculator_app/drawer/about%20us/aboutus_screen.dart';
import 'package:calculator_app/drawer/privacy%20policy/privacypolicy_screen.dart';
import 'package:calculator_app/drawer/profile/profile_screen.dart';
import 'package:calculator_app/drawer/setting/setting_provider_screen.dart';
import 'package:calculator_app/drawer/setting/setting_screen.dart';
import 'package:calculator_app/drawer/storage/storage_screen.dart';
import 'package:calculator_app/screen/calculatorScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp.router(
      title: 'Flutter Calculator',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settingsProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      // Wrap toggleDarkMode in a VoidCallback-compatible function
      routerConfig: routerConfig(() => settingsProvider.toggleDarkMode(!settingsProvider.isDarkMode)),
    );
  }
}

// Define GoRouter routes
GoRouter routerConfig(VoidCallback toggleTheme) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => CalculatorScreen(toggleTheme: toggleTheme),
      ),
      GoRoute(
        path: '/SettingsScreen',
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: '/AboutUsPageScreen',
        builder: (context, state) => AboutUsPageScreen(),
      ),
      GoRoute(
        path: '/PrivacyPolicyScreen',
        builder: (context, state) => PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: '/ProfileScreen',
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: '/SettingsScreen',
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: '/StorageScreen',
        builder: (context, state) => StorageScreen(),
      ),
    ],
  );
}
