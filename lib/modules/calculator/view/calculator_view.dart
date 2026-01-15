import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/infrastrucure/operation/operation_factory.dart';
import 'package:test_application/modules/calculator/bloc/calculator_bloc.dart';
import 'package:test_application/modules/calculator/bloc/calculator_event.dart';
import 'package:test_application/modules/calculator/bloc/calculator_state.dart';

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
                child: BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Equation Display (History)
                        Text(
                          state.equation,
                          key: const Key('display_equation'),
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
                          state.currentInput,
                          key: const Key('display_input'),
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
                  _buildButtonRow(context, ['7', '8', '9', '÷']),
                  _buildButtonRow(context, ['4', '5', '6', '×']),
                  _buildButtonRow(context, ['1', '2', '3', '-']),
                  _buildButtonRow(context, ['C', '0', '=', '+']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, List<String> labels) {
    return Row(
      children: labels.map((label) {
        return CalcButton(
          label: label,
          color: _getButtonColor(label),
          onTap: () => _handleTap(context, label),
        );
      }).toList(),
    );
  }

  Color _getButtonColor(String label) {
    if (label == 'C') return Colors.grey;
    if (['÷', '×', '-', '+', '='].contains(label)) return Colors.orange;
    return const Color(0xFF333333);
  }

  void _handleTap(BuildContext context, String label) {
    final bloc = context.read<CalculatorBloc>();

    if (label == 'C') {
      bloc.add(ClearPressed());
      return;
    }

    if (label == '=') {
      bloc.add(CalculatePressed());
      return;
    }

    final operation = OperationFactory.getOperation(label);
    if (operation != null) {
      bloc.add(OperationPressed(operation, label));
    } else {
      bloc.add(DigitPressed(label));
    }
  }
}

class CalcButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const CalcButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: onTap,
            child: Text(
              label,
              key: Key('btn_$label'),
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
