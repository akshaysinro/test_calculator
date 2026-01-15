import 'package:equatable/equatable.dart';
import 'package:test_application/domain/operation/operation.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object?> get props => [];
}

class DigitPressed extends CalculatorEvent {
  final String digit;

  const DigitPressed(this.digit);

  @override
  List<Object?> get props => [digit];
}

class OperationPressed extends CalculatorEvent {
  final Operation operation;
  final String symbol;

  const OperationPressed(this.operation, this.symbol);

  @override
  List<Object?> get props => [operation, symbol];
}

class ButtonPressed extends CalculatorEvent {
  final String label;

  const ButtonPressed(this.label);

  @override
  List<Object?> get props => [label];
}

class CalculatePressed extends CalculatorEvent {}

class ClearPressed extends CalculatorEvent {}
