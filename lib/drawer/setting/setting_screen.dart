import 'package:calculator_app/drawer/setting/setting_provider_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context); // Access the provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dark Mode Toggle
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Switch between light and dark themes'),
              value: settingsProvider.isDarkMode,
              onChanged: (value) {
                settingsProvider.toggleDarkMode(value);
              },
            ),
            const Divider(),

            // Scientific Calculator Mode
            SwitchListTile(
              title: const Text('Scientific Mode'),
              subtitle: const Text('Enable advanced scientific calculations'),
              value: settingsProvider.scientificMode,
              onChanged: (value) {
                settingsProvider.toggleScientificMode(value);
              },
            ),
            const Divider(),

            // Font Size Slider
            const Text(
              'Adjust Font Size',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: settingsProvider.fontSize,
              min: 14.0,
              max: 28.0,
              divisions: 6,
              label: settingsProvider.fontSize.toString(),
              onChanged: (value) {
                settingsProvider.setFontSize(value);
              },
            ),
            const Divider(),

            // Reset Preferences
            Center(
              child: ElevatedButton(
                onPressed: () {
                  settingsProvider.resetSettings();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings reset to default!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('Reset to Default'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
