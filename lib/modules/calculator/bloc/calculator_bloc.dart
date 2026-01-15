import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/modules/calculator/bloc/calculator_event.dart';
import 'package:test_application/modules/calculator/bloc/calculator_state.dart';
import 'package:test_application/modules/calculator/interactor/calculator_interactor.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculatorInteractor _interactor;

  CalculatorBloc(this._interactor) : super(CalculatorState.initial()) {
    on<DigitPressed>(_onDigitPressed);
    on<OperationPressed>(_onOperationPressed);
    on<CalculatePressed>(_onCalculatePressed);
    on<ClearPressed>(_onClearPressed);
  }

  void _onDigitPressed(DigitPressed event, Emitter<CalculatorState> emit) {
    _interactor.appendDigit(event.digit);
    emit(_formatState());
  }

  void _onOperationPressed(
    OperationPressed event,
    Emitter<CalculatorState> emit,
  ) {
    _interactor.setOperation(event.operation, event.symbol);
    emit(_formatState());
  }

  void _onCalculatePressed(
    CalculatePressed event,
    Emitter<CalculatorState> emit,
  ) {
    _interactor.calculate();
    emit(_formatState());
  }

  void _onClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    _interactor.reset();
    emit(_formatState());
  }

  CalculatorState _formatState() {
    String formattedInput = _formatResult(_interactor.currentInput);
    String equation = "";

    if (_interactor.firstOperand != null &&
        _interactor.operatorSymbol != null) {
      equation =
          "${_formatResult(_interactor.firstOperand!.toString())} ${_interactor.operatorSymbol}";
    }

    return CalculatorState(currentInput: formattedInput, equation: equation);
  }

  String _formatResult(String valueStr) {
    if (valueStr.endsWith(".0")) {
      return valueStr.substring(0, valueStr.length - 2);
    }
    return valueStr;
  }
}
