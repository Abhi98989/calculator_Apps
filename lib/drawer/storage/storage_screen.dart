import 'package:flutter/material.dart';

class StorageScreen extends StatelessWidget {
  // A simple list to simulate the stored calculation history
  final List<Map<String, String>> calculationHistory = [
    {'expression': '5 + 3', 'result': '8'},
    {'expression': '10 - 2', 'result': '8'},
    {'expression': '7 * 6', 'result': '42'},
    {'expression': '20 / 4', 'result': '5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculation History')),
      body: calculationHistory.isEmpty
          ? Center(child: Text('No history available'))
          : ListView.builder(
              itemCount: calculationHistory.length,
              itemBuilder: (context, index) {
                final calc = calculationHistory[index];
                return ListTile(
                  title: Text(calc['expression']!),
                  subtitle: Text(calc['result']!),
                );
              },
            ),
    );
  }
}
