import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/modules/calculator/bloc/calculator_bloc.dart';
import 'package:test_application/modules/calculator/bloc/calculator_event.dart';
import 'package:test_application/modules/calculator/bloc/calculator_state.dart';
import 'package:test_application/modules/calculator/helper/calculator_button_style.dart';

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
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            state.equation,
                            key: const Key('display_equation'),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Current Input Display
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            state.currentInput,
                            key: const Key('display_input'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // 2. Button Area
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: _buildButtonRow(context, ['7', '8', '9', '÷']),
                    ),
                    Expanded(
                      child: _buildButtonRow(context, ['4', '5', '6', '×']),
                    ),
                    Expanded(
                      child: _buildButtonRow(context, ['1', '2', '3', '-']),
                    ),
                    Expanded(
                      child: _buildButtonRow(context, ['C', '0', '=', '+']),
                    ),
                  ],
                ),
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
          color: CalculatorButtonStyle.getButtonColor(label),
          onTap: () => _handleTap(context, label),
        );
      }).toList(),
    );
  }

  void _handleTap(BuildContext context, String label) {
    context.read<CalculatorBloc>().add(ButtonPressed(label));
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
        child: SizedBox.expand(
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
