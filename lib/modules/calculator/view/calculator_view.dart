import 'package:flutter/material.dart';
import 'package:test_application/infrastrucure/operation/operation_factory.dart';
import 'package:test_application/modules/calculator/presenter/calculator_presenter.dart';

class CalculatorScreen extends StatefulWidget {
  // Presenter is injected (usually via Router/Constructor)
  // For StatefulWidget, we might need a way to set it or pass it.
  // We will assume it's passed or assigned later for this "Passive View".
  final CalculatorPresenter Function(CalculatorView) presenterBuilder;

  const CalculatorScreen({super.key, required this.presenterBuilder});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>
    implements CalculatorView {
  late CalculatorPresenter _presenter;

  String _equation = "";
  String _currentInput = "0";

  @override
  void initState() {
    super.initState();
    _presenter = widget.presenterBuilder(this);
  }

  @override
  void updateEquation(String equation) {
    setState(() {
      _equation = equation;
    });
  }

  @override
  void updateInput(String input) {
    setState(() {
      _currentInput = input;
    });
  }

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Equation Display (History)
                    Text(
                      _equation,
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
                      _currentInput,
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
        return CalcButton(
          label: label,
          color: _getButtonColor(label),
          onTap: () => _handleTap(label),
        );
      }).toList(),
    );
  }

  Color _getButtonColor(String label) {
    if (label == 'C') return Colors.grey;
    if (['÷', '×', '-', '+', '='].contains(label)) return Colors.orange;
    return const Color(0xFF333333);
  }

  void _handleTap(String label) {
    if (label == 'C') {
      _presenter.onClearPressed();
      return;
    }

    if (label == '=') {
      _presenter.onCalculatePressed();
      return;
    }

    final operation = OperationFactory.getOperation(label);
    if (operation != null) {
      _presenter.onOperationPressed(operation, label);
    } else {
      _presenter.onDigitPressed(label);
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
