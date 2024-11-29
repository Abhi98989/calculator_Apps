import 'dart:math';

class CalculatorLogic {
  String displayText = '0';
  String input = '';
  double? result;
  String? operator;
  List<String> calculationHistory = [];

  // Button pressed handler
  void onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      clearAll();
    } else if (['+', '-', '*', '/'].contains(buttonText)) {
      setOperator(buttonText);
    } else if (buttonText == '=') {
      calculateResult();
    } else if (['sin', 'cos', 'tan', 'log', '√', '^2', 'deg'].contains(buttonText)) {
      calculateScientificOperation(buttonText);
    } else {
      appendInput(buttonText);
    }
  }

  void clearAll() {
    displayText = '0';
    input = '';
    result = null;
    operator = null;
  }

  void appendInput(String value) {
    if (value == '.' && input.contains('.')) return; // Prevent multiple dots
    input += value;
    displayText = input;
  }

  void setOperator(String op) {
    if (input.isEmpty && result == null) return;

    if (result == null) {
      result = double.tryParse(input) ?? 0;
    } else if (operator != null) {
      calculateResult();
    }

    operator = op;
    input = '';
    displayText = ((result != null ? result?.toStringAsFixed(4) : '0')! + ' $operator');
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
          displayText = 'Error';
          resetAfterError();
          return;
        }
        break;
    }

    displayText = result!.toStringAsFixed(4);
    calculationHistory.add('${result.toString()} $operator $currentInput = $displayText');
    input = '';
    operator = null;
  }

  void calculateScientificOperation(String operation) {
    try {
      double currentInput = double.tryParse(input) ?? result ?? 0;

      switch (operation) {
        case 'sin':
          currentInput = sin(currentInput * (pi / 180));
          break;
        case 'cos':
          currentInput = cos(currentInput * (pi / 180));
          break;
        case 'tan':
          currentInput = tan(currentInput * (pi / 180));
          break;
        case 'log':
          if (currentInput > 0) {
            currentInput = log(currentInput);
          } else {
            throw Exception('Invalid input for log');
          }
          break;
        case '√':
          if (currentInput >= 0) {
            currentInput = sqrt(currentInput);
          } else {
            throw Exception('Negative square root');
          }
          break;
        case '^2':
          currentInput = pow(currentInput, 2).toDouble();
          break;
        case 'deg':
          currentInput = currentInput * (180 / pi);
          break;
      }

      displayText = currentInput.toStringAsFixed(4);
      calculationHistory.add('$operation($input) = $displayText');
      input = '';
    } catch (e) {
      displayText = 'Error';
    }
  }

  void resetAfterError() {
    input = '';
    operator = null;
    result = null;
  }

  void backspace() {
    if (input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
      displayText = input.isEmpty ? '0' : input;
    }
  }
}
