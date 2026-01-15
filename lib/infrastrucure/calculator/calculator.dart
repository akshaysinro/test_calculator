import 'package:test_application/domain/operation/operation.dart';

class Calculator {
  Operation? _operation;

  void setOperation(Operation op){
_operation=op;

  }

  double calculate(double a, double b){
return _operation!.calculate(a, b);
  }
}