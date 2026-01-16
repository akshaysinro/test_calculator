import 'package:test_application/domain/operation/operation.dart';

abstract class ICalculator {
  void setOperation(Operation op);
  double calculate(double a, double b);
}
