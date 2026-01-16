import 'package:test_application/domain/calculator/calculator_interface.dart';
import 'package:test_application/domain/operation/operation.dart';

class Calculator implements ICalculator {
  Operation? _operation;

  @override
  void setOperation(Operation op) {
    _operation = op;
  }

  @override
  double calculate(double a, double? b) {
    return _operation!.calculate(a, b);
  }
}
