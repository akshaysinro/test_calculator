import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final String equation;
  final String currentInput;

  const CalculatorState({required this.equation, required this.currentInput});

  factory CalculatorState.initial() {
    return const CalculatorState(equation: "", currentInput: "0");
  }

  CalculatorState copyWith({String? equation, String? currentInput}) {
    return CalculatorState(
      equation: equation ?? this.equation,
      currentInput: currentInput ?? this.currentInput,
    );
  }

  @override
  List<Object?> get props => [equation, currentInput];
}
