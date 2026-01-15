import 'package:test_application/domain/operation/operation.dart';

class MinusOperation implements Operation {
  @override
  double calculate(double a, double b) {
    return a-b;
  }
}