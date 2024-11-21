import 'package:flutter/material.dart';

class BackspaceButton extends StatelessWidget {
  final VoidCallback onBackspacePressed;

  BackspaceButton({required this.onBackspacePressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onBackspacePressed, // Handle backspace press
      child: Icon(
        Icons.backspace,
        color: Colors.white, // Change icon color to white for better visibility
      ),
      backgroundColor: Colors.blue, // Define background color (adjust to your theme)
      tooltip: 'Backspace',
      mini: true, // Optional: make the button smaller if needed
      elevation: 4.0, // Optional: add some elevation for a subtle shadow effect
    );
  }
}
