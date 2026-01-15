import 'package:test_application/domain/operation/operation.dart';

class OperationFactory {
  static final Map<String, Operation> _operations = {};

  static void register(String symbol, Operation operation) {
    _operations[symbol] = operation;
  }

  static Operation? getOperation(String label) => _operations[label];
}
