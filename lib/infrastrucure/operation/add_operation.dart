import 'package:test_application/domain/operation/operation.dart';

class AddOperation implements Operation {
  @override
  double calculate(double a,double b) {
    return a+b;
  }
}