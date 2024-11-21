import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle textStyle;

  CalculatorButton({
    required this.text,
    required this.onTap,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _getButtonColor(text),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle, // Use the passed TextStyle
          ),
        ),
      ),
    );
  }

  // Function to get the button color based on button type
  Color _getButtonColor(String buttonText) {
    if (['+', '-', '*', '/', '='].contains(buttonText)) {
      return Colors.orangeAccent; // Operator and equals buttons
    } else if (buttonText == 'C') {
      return Colors.redAccent; // Clear button
    } else {
      return Colors.blueAccent; // Number buttons
    }
  }
}
