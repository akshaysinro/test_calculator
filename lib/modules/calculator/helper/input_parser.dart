enum InputType { digit, operator, equality, clear, unknown }

class InputParser {
  static InputType parse(String label) {
    if (RegExp(r'^[0-9.]$').hasMatch(label)) {
      return InputType.digit;
    } else if (['+', '-', '×', '÷'].contains(label)) {
      return InputType.operator;
    } else if (label == '=') {
      return InputType.equality;
    } else if (label == 'C') {
      return InputType.clear;
    }
    return InputType.unknown;
  }
}
