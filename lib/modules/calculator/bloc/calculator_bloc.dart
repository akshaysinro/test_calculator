import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/infrastrucure/operation/operation_factory.dart';
import 'package:test_application/modules/calculator/bloc/calculator_event.dart';
import 'package:test_application/modules/calculator/bloc/calculator_state.dart';
import 'package:test_application/modules/calculator/helper/result_formatter.dart';
import 'package:test_application/modules/calculator/interactor/calculator_interactor.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculatorInteractor _interactor;

  CalculatorBloc(this._interactor) : super(CalculatorState.initial()) {
    on<DigitPressed>(_onDigitPressed);
    on<OperationPressed>(_onOperationPressed);
    on<CalculatePressed>(_onCalculatePressed);
    on<ClearPressed>(_onClearPressed);
    on<ButtonPressed>(_onButtonPressed);
  }

  void _onButtonPressed(ButtonPressed event, Emitter<CalculatorState> emit) {
    if (event.label == 'C') {
      _interactor.reset();
    } else if (event.label == '=') {
      _interactor.calculate();
    } else {
      final operation = OperationFactory.getOperation(event.label);
      if (operation != null) {
        _interactor.setOperation(operation, event.label);
      } else {
        _interactor.appendDigit(event.label);
      }
    }
    emit(_formatState());
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
    String formattedInput = ResultFormatter.format(_interactor.currentInput);
    String equation = "";

    if (_interactor.firstOperand != null &&
        _interactor.operatorSymbol != null) {
      equation =
          "${ResultFormatter.format(_interactor.firstOperand!.toString())} ${_interactor.operatorSymbol}";
    }

    return CalculatorState(currentInput: formattedInput, equation: equation);
  }
}
