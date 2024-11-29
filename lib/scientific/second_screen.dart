import 'package:calculator_app/scientific/calcul_logic.dart';
import 'package:calculator_app/scientific/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/button/backspace_button.dart';
import 'package:calculator_app/button/button_grid.dart';
import 'package:calculator_app/drawer/drawer_screen.dart';

class CalculatorApp extends StatefulWidget {
  final VoidCallback toggleTheme;

  CalculatorApp({required this.toggleTheme});

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final CalculatorLogic calculator = CalculatorLogic();
  bool showAdvancedButtons = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(showAdvancedButtons ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: () {
              setState(() {
                showAdvancedButtons = !showAdvancedButtons;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(history: calculator.calculationHistory),
                ),
              );
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
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(32),
            child: Text(
              calculator.displayText,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ButtonGrid(
              onButtonPressed: (buttonText) {
                setState(() {
                  calculator.onButtonPressed(buttonText);
                });
              },
              isScientificMode: showAdvancedButtons,
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: BackspaceButton(
          onBackspacePressed: () {
            setState(() {
              calculator.backspace();
            });
          },
        ),
      ),
    );
  }
}
