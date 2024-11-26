import 'dart:math';
import 'package:calculator_app/drawer/storage/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/button/backspace_button.dart';
import 'package:calculator_app/drawer/drawer_screen.dart';
import 'package:calculator_app/button/button_grid.dart';
import 'package:expressions/expressions.dart'; // Add this dependency

// History screen to display the calculation history
class HistoryScreen extends StatelessWidget {
  final List<String> history;

  HistoryScreen({required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(history[index]),
          );
        },
      ),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  final VoidCallback toggleTheme;

  CalculatorApp({required this.toggleTheme});

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String displayText = '0';
  String input = '';
  double? result;
  List<String> calculationHistory = []; // Store calculation history
  List<double> values = [];
  bool showAdvancedButtons = false;

  // Handle button presses
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        clearAll();
      } else if (buttonText == '=') {
        calculateResult();
      } else if (['sin', 'cos', 'tan', 'log', '√', '^2', 'deg'].contains(buttonText)) {
        handleScientificOperation(buttonText);
      } else if (['min', 'median', 'mode'].contains(buttonText)) {
        calculateStatistics(buttonText);
      } else if (buttonText == ',') {
        addToValues();
      } else {
        handleNumber(buttonText);
      }
    });
  }

  // Clear all inputs
  void clearAll() {
    displayText = '0';
    input = '';
    result = null;
    values.clear();
  }

  // Add current input to values list for statistics calculations
  void addToValues() {
    if (input.isNotEmpty) {
      double? value = double.tryParse(input);
      if (value != null) values.add(value);
      input = '';
      displayText = 'Values: ${values.join(', ')}';
    }
  }

  // Handle scientific operations
  void handleScientificOperation(String operation) {
    double currentInput = double.tryParse(input) ?? 0;

    switch (operation) {
      case 'sin':
        result = sin(currentInput * (pi / 180)); // Convert to radians
        break;
      case 'cos':
        result = cos(currentInput * (pi / 180));
        break;
      case 'tan':
        result = tan(currentInput * (pi / 180));
        break;
      case 'log':
        result = log(currentInput);
        break;
      case '√':
        result = sqrt(currentInput);
        break;
      case '^2':
        result = pow(currentInput, 2).toDouble(); // Square the number
        break;
      case 'deg':
        result = currentInput * (180 / pi); // Convert radians to degrees
        break;
      default:
        result = 0;
    }

    displayText = result!.toStringAsFixed(4);
    input = '';
  }

  // Calculate statistics: min, median, mode
  void calculateStatistics(String operation) {
    if (values.isEmpty) {
      displayText = 'No values';
      return;
    }

    switch (operation) {
      case 'min':
        result = values.reduce((a, b) => a < b ? a : b);
        break;
      case 'median':
        List<double> sorted = [...values]..sort();
        int middle = sorted.length ~/ 2;
        result = (sorted.length % 2 == 1)
            ? sorted[middle]
            : (sorted[middle - 1] + sorted[middle]) / 2;
        break;
      case 'mode':
        Map<double, int> freq = {};
        for (var value in values) {
          freq[value] = (freq[value] ?? 0) + 1;
        }
        int maxFreq = freq.values.reduce((a, b) => a > b ? a : b);
        result = freq.entries.firstWhere((entry) => entry.value == maxFreq).key;
        break;
    }

    displayText = '$operation: ${result!.toStringAsFixed(4)}';
  }

  // Handle number inputs
  void handleNumber(String buttonText) {
    if (buttonText == '.' && input.contains('.')) return;

    input += buttonText;
    displayText = input;
  }

  // Calculate the result (basic functionality for '=' button)
  void calculateResult() {
    if (input.isEmpty) {
      displayText = '0';
      return;
    }

    try {
      final expression = Expression.parse(input); // Parse the expression
      final evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {}); // Evaluate the result

      if (result is double) {
        displayText = result.toStringAsFixed(4); // Display result
        calculationHistory.add('$input = ${result.toStringAsFixed(4)}'); // Add result to history
      } else {
        displayText = 'Invalid Expression'; // Invalid result
      }
    } catch (e) {
      displayText = 'Invalid Expression'; // Catch any error during evaluation
    }

    input = ''; // Clear input after calculation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(showAdvancedButtons ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: () {
              setState(() {
                showAdvancedButtons = !showAdvancedButtons; // Toggle advanced buttons
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to HistoryScreen to show the calculation history
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(history: calculationHistory),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.nightlight_round),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          // Display Screen
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                displayText,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Divider(),
          // Button Grid
          ButtonGrid(
            onButtonPressed: onButtonPressed,
            isScientificMode: showAdvancedButtons,
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Position buttons at opposite ends
        children: [
          // History button
          Padding(
            padding: const EdgeInsets.only(right: 8.0), // Padding to avoid edge collision
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              // child: FloatingActionButton(
              //   heroTag: 'history',
              //   onPressed: () {
              //     // Navigate to StorageScreen with the history
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => StorageScreen(calculationHistory: calculationHistory),
              //       ),
              //     );
              //   },
              //   child: const Icon(Icons.history),
              // ),
            ),
          ),
          // Backspace button
          Padding(
            padding: const EdgeInsets.only(left: 18.0), // Padding to avoid edge collision
            child: BackspaceButton(
              onBackspacePressed: () {
                setState(() {
                  if (input.isNotEmpty) {
                    input = input.substring(0, input.length - 1);
                    displayText = input.isEmpty ? '0' : input;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
