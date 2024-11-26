import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Add this import for navigation

class ModeScreen extends StatefulWidget {
  const ModeScreen({Key? key}) : super(key: key);

  @override
  _ModeScreenState createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  bool isScientificMode = false;

  // Toggle between normal and scientific calculator mode
  void toggleScientificMode(bool value) {
    setState(() {
      isScientificMode = value;
      // Navigate to CalculatorScreen with the new mode
      context.go('/', extra: isScientificMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Calculator Mode'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose Calculator Mode',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Scientific Calculator Mode'),
                subtitle: const Text('Enable for advanced calculations'),
                value: isScientificMode,
                onChanged: toggleScientificMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
