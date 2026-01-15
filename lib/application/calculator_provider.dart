import 'package:flutter/material.dart';
import 'package:test_application/domain/operation/operation.dart';
import 'package:test_application/infrastrucure/calculator/calculator.dart';

class CalculatorProvider extends ChangeNotifier {
  Calculator calculator = Calculator();

  String _equation = "";
  String _currentInput = "0";
  double? _firstOperand;
  String? _operatorSymbol;
  Operation? _pendingOperation;
  bool _shouldResetInput = false;

  String get equation => _equation;
  String get currentInput => _currentInput;

  void appendDigit(String digit) {
    if (_shouldResetInput) {
      _currentInput = "";
      _shouldResetInput = false;
    }

    // Prevent leading zeros unless it's just "0"
    if (_currentInput == "0" && digit != ".") {
      _currentInput = digit;
    } else {
      // Prevent multiple decimals
      if (digit == "." && _currentInput.contains(".")) return;
      _currentInput += digit;
    }

    notifyListeners();
  }

  void setOperation(Operation op, String symbol) {
    // If we have an existing operation pending and we just typed a number, calculate first (chaining)
    if (_operatorSymbol != null && !_shouldResetInput) {
      calculate();
    }

    _firstOperand = double.tryParse(_currentInput);
    _pendingOperation = op;
    _operatorSymbol = symbol;

    // Update equation to show what we have so far
    _equation = "${_formatResult(_firstOperand ?? 0)} $symbol";

    _shouldResetInput =
        true; // Next digit input clears the display for the new number
    notifyListeners();
  }

  void calculate() {
    if (_firstOperand == null || _pendingOperation == null) return;

    double secondOperand = double.tryParse(_currentInput) ?? 0;

    double result = 0;
    try {
      calculator.setOperation(_pendingOperation!);
      result = calculator.calculate(_firstOperand!, secondOperand);
    } catch (e) {
      _currentInput = "Error";
      _resetState();
      notifyListeners();
      return;
    }

    // Show full equation in history (optional, or just clear it)
    // _equation = "${_formatResult(_firstOperand!)} $_operatorSymbol ${_formatResult(secondOperand)} =";
    _equation = ""; // Clearing equation as typically calc resets to result

    _currentInput = _formatResult(result);
    _firstOperand = result; // Allow chaining from result
    _operatorSymbol = null;
    _pendingOperation = null;
    _shouldResetInput = true;

    notifyListeners();
  }

  void reset() {
    _resetState();
    _currentInput = "0";
    _equation = "";
    notifyListeners();
  }

  void _resetState() {
    _firstOperand = null;
    _operatorSymbol = null;
    _pendingOperation = null;
    _shouldResetInput = false;
  }

  String _formatResult(double value) {
    String s = value.toString();
    if (s.endsWith(".0")) {
      return s.substring(0, s.length - 2);
    }
    return s;
  }
}
