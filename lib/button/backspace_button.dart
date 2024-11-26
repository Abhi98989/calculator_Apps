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
        color: Colors.white, // Icon color for visibility
        size: 30, // Increased icon size
      ),
      backgroundColor: Colors.blue, // Background color of the button
      tooltip: 'Backspace',
      mini: false, // Set to false to make the button larger
      elevation: 8.0, // Subtle shadow for a more prominent button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Optional: for rounded corners
      ),
    );
  }
}
