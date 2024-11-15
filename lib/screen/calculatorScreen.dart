// screen/calculator_screen.dart
import 'package:calculator_app/button/backspace_button.dart';
import 'package:calculator_app/button/button_grid.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  final Function toggleTheme;

  CalculatorScreen({required this.toggleTheme});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  String input = '';
  String calculationHistory = ''; // To store expressions like "2+2=4"
  double? result;
  String? operator;
  bool newNumber = false;

  // Function to handle button presses
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        clearAll();
      } else if (buttonText == '=') {
        if (operator != null) {
          calculateResult();
          displayText = '$calculationHistory'; // Format: [2+2=4]
          newNumber = true;
        }
      } else if (['+', '-', '*', '/'].contains(buttonText)) {
        handleOperator(buttonText);
      } else {
        handleNumber(buttonText);
      }
    });
  }

  void clearAll() {
    displayText = '0';
    input = '';
    calculationHistory = '';
    result = null;
    operator = null;
    newNumber = false;
  }

  void handleOperator(String buttonText) {
    if (operator != null && input.isNotEmpty) {
      calculateResult();
    } else if (input.isNotEmpty) {
      result = double.tryParse(input); // Initialize result if not set
    }

    operator = buttonText;
    calculationHistory = '${formatResult(result ?? 0)} $operator';
    displayText = calculationHistory;
    input = '';
    newNumber = true;
  }

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
          displayText = 'Error'; // Division by zero
          return;
        }
        break;
    }

    calculationHistory += '$input = ${formatResult(result ?? 0)}';
    input = '';
    operator = null;
  }

  String formatResult(double result) {
    return result == result.toInt() ? result.toInt().toString() : result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: [
          IconButton(
            icon: Icon(Icons.nightlight_round),
            onPressed: () => widget.toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          ButtonGrid(onButtonPressed: onButtonPressed),
        ],
      ),
      floatingActionButton: BackspaceButton(onBackspacePressed: () {
        setState(() {
          if (input.isNotEmpty) {
            input = input.substring(0, input.length - 1);
            displayText = input.isEmpty ? '0' : input;
          }
        });
      }),
    );
  }
}
