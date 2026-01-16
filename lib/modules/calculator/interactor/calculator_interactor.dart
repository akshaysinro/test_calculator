import 'package:test_application/domain/calculator/calculator_interface.dart';
import 'package:test_application/domain/operation/operation.dart';
import 'package:test_application/infrastrucure/calculator/calculator.dart';

abstract class CalculatorInteractor {
  String get currentInput;
  String? get operatorSymbol;
  double? get firstOperand;

  void appendDigit(String digit);
  void setOperation(Operation op, String symbol);
  void calculate();
  void reset();
}

class CalculatorInteractorImpl implements CalculatorInteractor {
  final ICalculator _calculator;

  CalculatorInteractorImpl({ICalculator? calculator})
    : _calculator =
          calculator ?? Calculator(); // Allow injection, default to real one

  // State
  String _currentInput = "0";
  double? _firstOperand;
  String? _operatorSymbol;
  Operation? _pendingOperation;
  bool _shouldResetInput = false;

  @override
  String get currentInput => _currentInput;
  @override
  String? get operatorSymbol => _operatorSymbol;
  @override
  double? get firstOperand => _firstOperand;

  @override
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

  @override
  void setOperation(Operation op, String symbol) {
    if (_operatorSymbol != null && !_shouldResetInput) {
      calculate();
    }

    _firstOperand = double.tryParse(_currentInput);
    _pendingOperation = op;
    _operatorSymbol = symbol;

    _shouldResetInput = true;
  }

  @override
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

    _currentInput = result.toString();
    _firstOperand = result;
    _operatorSymbol = null;
    _pendingOperation = null;
    _shouldResetInput = true;
  }

  @override
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
