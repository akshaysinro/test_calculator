import 'package:test_application/infrastrucure/operation/add_operation.dart';
import 'package:test_application/infrastrucure/operation/divide_operator.dart';
import 'package:test_application/infrastrucure/operation/minus_operation.dart';
import 'package:test_application/infrastrucure/operation/multiply_operation.dart';
import 'package:test_application/infrastrucure/operation/operation_factory.dart';

class DependencyInjection {
  static void init() {
    // Register Operations
    OperationFactory.register('+', AddOperation());
    OperationFactory.register('-', MinusOperation());
    OperationFactory.register('÷', DivideOperator());
    OperationFactory.register('×', MultiplyOperation());
  }
}
