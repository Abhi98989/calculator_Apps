import 'package:calculator_app/button/backspace_button.dart';
import 'package:calculator_app/button/button_grid.dart';
import 'package:calculator_app/drawer/drawer_screen.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const CalculatorScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0'; // Current display text
  String input = ''; // Current input value
  String calculationHistory = ''; // Tracks history of operations
  double? result; // Result of calculations
  String? operator; // Current operator
  bool newNumber = false; // Indicates if a new number is being entered

  // Handle button presses from the ButtonGrid
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        clearAll(); // Clear all values
      } else if (buttonText == '=') {
        if (operator != null) {
          calculateResult(); // Calculate the result
          newNumber = true;
        }
      } else if (['+', '-', '*', '/'].contains(buttonText)) {
        handleOperator(buttonText); // Handle operator input
      } else {
        handleNumber(buttonText); // Handle numerical input
      }
    });
  }

  // Clears all input and resets the calculator
  void clearAll() {
    displayText = '0';
    input = '';
    calculationHistory = '';
    result = null;
    operator = null;
    newNumber = false;
  }

  // Handles operator input
  void handleOperator(String buttonText) {
    if (operator != null && input.isNotEmpty) {
      calculateResult(); // Perform intermediate calculations
    } else if (input.isNotEmpty) {
      result = double.tryParse(input);
    }

    operator = buttonText;
    calculationHistory = '${formatResult(result ?? 0)} $operator';
    displayText = calculationHistory;
    input = '';
    newNumber = true;
  }

  // Handles number and decimal input
  void handleNumber(String buttonText) {
    if (buttonText == '.' && input.contains('.')) return; // Prevent multiple decimals

    if (newNumber) {
      input = buttonText;
      newNumber = false;
    } else {
      input += buttonText;
    }

    displayText = input;
  }

  // Performs the calculation based on the operator
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
          displayText = 'Error'; // Handle division by zero
          input = '';
          operator = null;
          return;
        }
        break;
    }

    calculationHistory += ' $input = ${formatResult(result ?? 0)}';
    displayText = formatResult(result ?? 0);
    input = '';
    operator = null;
  }

  // Formats results to remove unnecessary decimals
  String formatResult(double result) {
    return result == result.toInt() ? result.toInt().toString() : result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.nightlight_round),
            onPressed: widget.toggleTheme, // Toggle the theme using VoidCallback
          ),
        ],
      ),
      drawer: AppDrawer(), // Integrate a drawer menu
      body: Column(
        children: [
          // Display Area
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // Prevents text overflow
              ),
            ),
          ),
          const Divider(),
          // Button Grid
          ButtonGrid(onButtonPressed: onButtonPressed), // Pass button handling
        ],
      ),
      floatingActionButton: BackspaceButton(
        onBackspacePressed: () {
          setState(() {
            if (input.isNotEmpty) {
              input = input.substring(0, input.length - 1); // Remove last character
              displayText = input.isEmpty ? '0' : input;
            }
          });
        },
      ),
    );
  }
}
