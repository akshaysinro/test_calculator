import 'package:test_application/domain/operation/operation.dart';
import 'package:test_application/infrastrucure/calculator/calculator.dart';

class CalculatorInteractor {
  final Calculator _calculator = Calculator();

  // State from Provider (kept here in Interactor or in a separate Entity/Model)
  // For simplicity matching previous logic, we keep state here.
  String _currentInput = "0";
  double? _firstOperand;
  String? _operatorSymbol;
  Operation? _pendingOperation;
  bool _shouldResetInput = false;

  // Getters for current state to pass to Presenter
  String get currentInput => _currentInput;
  String? get operatorSymbol => _operatorSymbol;
  double? get firstOperand => _firstOperand;

  void appendDigit(String digit) {
    if (_shouldResetInput) {
      _currentInput = "";
      _shouldResetInput = false;
    }

    if (_currentInput == "0" && digit != ".") {
      _currentInput = digit;
    } else {
      if (digit == "." && _currentInput.contains(".")) return;
      _currentInput += digit;
    }
  }

  void setOperation(Operation op, String symbol) {
    if (_operatorSymbol != null && !_shouldResetInput) {
      calculate();
    }

    _firstOperand = double.tryParse(_currentInput);
    _pendingOperation = op;
    _operatorSymbol = symbol;

    // Logic from provider: next input clears display
    _shouldResetInput = true;
  }

  void calculate() {
    if (_firstOperand == null || _pendingOperation == null) return;

    double secondOperand = double.tryParse(_currentInput) ?? 0;
    double result = 0;

    try {
      _calculator.setOperation(_pendingOperation!);
      result = _calculator.calculate(_firstOperand!, secondOperand);
    } catch (e) {
      _currentInput = "Error";
      _resetState();
      return;
    }

    _currentInput = result.toString(); // Presenter will format this
    _firstOperand = result;
    _operatorSymbol = null;
    _pendingOperation = null;
    _shouldResetInput = true;
  }

  void reset() {
    _resetState();
    _currentInput = "0";
  }

  void _resetState() {
    _firstOperand = null;
    _operatorSymbol = null;
    _pendingOperation = null;
    _shouldResetInput = false;
  }
}
