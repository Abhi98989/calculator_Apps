import 'package:flutter/material.dart';
import 'package:calculator_app/button/buttons.dart';

class ButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;
  final bool isScientificMode;

  ButtonGrid({required this.onButtonPressed, this.isScientificMode = false});

  @override
  Widget build(BuildContext context) {
    final List<String> standardButtons = [
      '6', '7', '8', '9', '/',
      '2', '3', '4', '5', '*',
      '0', '1', '.', '+', '-',
      'C', 'deg', '^2', '√', '=',
    ];

    final List<String> advancedButtons = [
      'sin', 'cos', 'tan', 'log', ',',
    ];

    // Combine buttons based on mode
    final List<String> buttons = isScientificMode
        ? [...standardButtons, ...advancedButtons]
        : standardButtons;

    // Adjust column count based on mode
    final int crossAxisCount = isScientificMode ? 5 : 5;

    return Expanded(
      flex: 3,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          final String button = buttons[index];

          return CalculatorButton(
            text: button,
            onTap: () => onButtonPressed(button),
            textStyle: TextStyle(
              fontSize: 20,
              color: _getButtonTextColor(button),
            ),
            backgroundColor: _getButtonBackgroundColor(button),
          );
        },
      ),
    );
  }

  // Helper method to determine button text color
  Color _getButtonTextColor(String button) {
    if (['C', '=', '+', '-', '*', '/', '^2', '√'].contains(button)) {
      return Colors.white;
    }
    return Colors.black87;
  }

  // Helper method to determine button background color
  Color _getButtonBackgroundColor(String button) {
    if (['C', '=', '+', '-', '*', '/', '^2', '√'].contains(button)) {
      return Colors.blueGrey; // Highlight action and operator buttons
    }
    if (['sin', 'cos', 'tan', 'log', 'deg'].contains(button)) {
      return Colors.lightBlueAccent; // Highlight scientific buttons
    }
    return Colors.grey[300]!; // Default background for number buttons
  }
}
