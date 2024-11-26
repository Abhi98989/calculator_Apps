import 'package:calculator_app/button/buttons.dart';
import 'package:flutter/material.dart';

class ButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;
  final bool isScientificMode; // Determines the mode

  ButtonGrid({required this.onButtonPressed, this.isScientificMode = false});
  @override
  Widget build(BuildContext context) {
    final List<String> standardButtons = [
  '6', '7', '8','9', '/',
  '2', '3', '4', '5','*',
  '0', '1', '.','+', '-',
  'C',  'deg',
  '^2', '√', '=',
];

final List<String> advancedButtons = [
  
  'sin', 'cos', 'tan', 'log',
  'min', 'med', 'mod', ',',
];

// Combine buttons based on mode
final List<String> buttons = isScientificMode
    ? [...standardButtons, ...advancedButtons]
    : standardButtons;

   // final buttons = isScientificMode ? scientificButtons : standardButtons;

    return Expanded(
      flex: 3,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 4 buttons per row
          crossAxisSpacing: 8, // Horizontal space between buttons
          mainAxisSpacing: 8, // Vertical space between buttons
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          return CalculatorButton(
            text: buttons[index],
            onTap: () => onButtonPressed(buttons[index]),
            textStyle: TextStyle(fontSize: 20), // Optionally customize textStyle
          );
        },
      ),
    );
  }
}
