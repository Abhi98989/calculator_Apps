import 'dart:math';
import 'package:calculator_app/button/backspace_button.dart';
import 'package:calculator_app/button/button_grid.dart';
import 'package:calculator_app/drawer/drawer_screen.dart';
import 'package:calculator_app/drawer/storage/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<String> calculationHistory = [];

class CalculatorScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const CalculatorScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  String input = '';
  double? result;
  String? operator;
  bool newNumber = false;

  // Function to update the history with result
  void updateHistory() {
    calculationHistory.add(displayText); // Store the calculation result in history
  }

  // Function to handle button presses
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        clearAll();
      } else if (buttonText == '=') {
        if (operator != null) {
          calculateResult();
          updateHistory(); // Save to history after calculation
        }
      } else if (['+', '-', '*', '/', '√', '^2', 'deg'].contains(buttonText)) {
        handleOperator(buttonText);
      } else {
        handleNumber(buttonText);
      }
    });
  }

  // Clear all data
  void clearAll() {
    displayText = '0';
    input = '';
    result = null;
    operator = null;
    newNumber = false;
  }

  // Handle operators and calculate the result
  void handleOperator(String buttonText) {
    if (operator != null && input.isNotEmpty) {
      calculateResult();
    } else if (input.isNotEmpty) {
      result = double.tryParse(input);
    }

    operator = buttonText;
    displayText = '$result $operator';
    input = '';
    newNumber = true;
  }

  // Handle number inputs
  void handleNumber(String buttonText) {
    if (buttonText == '.' && input.contains('.')) return;

    if (newNumber) {
      input = buttonText;
      newNumber = false;
    } else {
      input += buttonText;
    }

    displayText = input;
  }

  // Perform the actual calculation
  void calculateResult() {
    if (input.isEmpty || operator == null) return;

    double currentInput = double.tryParse(input) ?? 0;

    switch (operator) {
      case '+':
        result = (result ?? 0) + currentInput;
        break;
      case '-':
        result = (result ?? 0) - currentInput;
        break;
      case '*':
        result = (result ?? 0) * currentInput;
        break;
      case '/':
        if (currentInput != 0) {
          result = (result ?? 0) / currentInput;
        } else {
          displayText = 'Error';
          input = '';
          operator = null;
          return;
        }
        break;
      case '√':
        // Square root: handle only positive numbers
        if (currentInput < 0) {
          displayText = 'Error';
          input = '';
          operator = null;
          return;
        }
        result = sqrt(currentInput);
        break;
      case '^2':
        // Square the number
        result = pow(currentInput, 2).toDouble();
        break;
      case 'deg':
        // Convert radians to degrees
        result = currentInput * (180 / pi);
        break;
    }

    // Display the result and reset the operator and input for the next operation
    displayText = result.toString();
    input = '';
    operator = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.science),
            onPressed: () {
              // Navigate to the scientific calculator screen
              context.go('/CalculatorApp');
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
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Divider(),
          // Normal mode button grid
          ButtonGrid(onButtonPressed: onButtonPressed),
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
              child: FloatingActionButton(
                heroTag: 'history',
                onPressed: () {
                  // Navigate to StorageScreen with the history
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StorageScreen(calculationHistory: calculationHistory),
                    ),
                  );
                },
                child: const Icon(Icons.history),
              ),
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
