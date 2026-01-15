import 'package:test_application/domain/operation/operation.dart';
import 'package:test_application/modules/calculator/interactor/calculator_interactor.dart';

abstract class CalculatorView {
  void updateEquation(String equation);
  void updateInput(String input);
}

class CalculatorPresenter {
  final CalculatorView _view;
  final CalculatorInteractor _interactor;

  CalculatorPresenter(this._view, this._interactor) {
    _updateView();
  }

  void onDigitPressed(String digit) {
    _interactor.appendDigit(digit);
    _updateView();
  }

  void onOperationPressed(Operation op, String symbol) {
    _interactor.setOperation(op, symbol);
    _updateView();
  }

  void onCalculatePressed() {
    _interactor.calculate();
    _updateView();
  }

  void onClearPressed() {
    _interactor.reset();
    _updateView();
  }

  void _updateView() {
    String formattedInput = _formatResult(_interactor.currentInput);
    _view.updateInput(formattedInput);

    String equation = "";
    if (_interactor.firstOperand != null &&
        _interactor.operatorSymbol != null) {
      equation =
          "${_formatResult(_interactor.firstOperand!.toString())} ${_interactor.operatorSymbol}";
    }
    _view.updateEquation(equation);
  }

  String _formatResult(String valueStr) {
    // Basic formatting: remove trailing .0
    // Try parse to handle potential "Error" string or others safely if needed,
    // but here we just check string pattern.
    if (valueStr.endsWith(".0")) {
      return valueStr.substring(0, valueStr.length - 2);
    }
    return valueStr;
  }
}
