import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/application/calculator_provider.dart';
import 'package:test_application/infrastrucure/operation/operation_factory.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Display Area
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Consumer<CalculatorProvider>(
                  builder: (context, provider, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Equation Display (History)
                        Text(
                          provider.equation,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        // Current Input Display
                        Text(
                          provider.currentInput,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 72,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // 2. Button Area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildButtonRow(['7', '8', '9', '÷']),
                  _buildButtonRow(['4', '5', '6', '×']),
                  _buildButtonRow(['1', '2', '3', '-']),
                  _buildButtonRow(['C', '0', '=', '+']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> labels) {
    return Row(
      children: labels.map((label) {
        return CalcButton(label: label, color: _getButtonColor(label));
      }).toList(),
    );
  }

  Color _getButtonColor(String label) {
    if (label == 'C') return Colors.grey;
    if (['÷', '×', '-', '+', '='].contains(label)) return Colors.orange;
    return const Color(0xFF333333);
  }
}

class CalcButton extends StatelessWidget {
  final String label;
  final Color color;

  const CalcButton({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CalculatorProvider>();

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: AspectRatio(
          aspectRatio: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: () => _handleTap(provider),
            child: Text(
              label,
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap(CalculatorProvider provider) {
    if (label == 'C') {
      provider.reset();
      return;
    }

    if (label == '=') {
      provider.calculate();
      return;
    }

    final operation = OperationFactory.getOperation(label);
    if (operation != null) {
      provider.setOperation(operation, label);
    } else {
      provider.appendDigit(label);
    }
  }
}
