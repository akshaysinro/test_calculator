import 'package:flutter/material.dart';

class CalculatorButtonStyle {
  static Color getButtonColor(String label) {
    if (label == 'C') return Colors.grey;
    if (['÷', '×', '-', '+', '='].contains(label)) return Colors.orange;
    return const Color(0xFF333333);
  }
}
