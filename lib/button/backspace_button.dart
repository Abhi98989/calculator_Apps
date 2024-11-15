import 'package:flutter/material.dart';

class BackspaceButton extends StatelessWidget {
  final VoidCallback onBackspacePressed;

  BackspaceButton({required this.onBackspacePressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      
      onPressed: onBackspacePressed, // Handle backspace press
      child: Icon(Icons.backspace,color: Colors.brown,),
      tooltip: 'Backspace',
    );
  }
}
