// button_grid.dart
import 'package:calculator_app/button/buttons.dart';
import 'package:flutter/material.dart';

class ButtonGrid extends StatelessWidget {
  final Function(String) onButtonPressed;

  ButtonGrid({required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      '7', '8', '9', '/',
      '4', '5', '6', '*',
      '1', '2', '3', '-',
      'C', '0', '=', '+',
    ];

    return Expanded(
      flex: 3,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 buttons per row
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          return CalculatorButton(
            text: buttons[index],
            onTap: () => onButtonPressed(buttons[index]),
          );
        },
      ),
    );
  }
}
