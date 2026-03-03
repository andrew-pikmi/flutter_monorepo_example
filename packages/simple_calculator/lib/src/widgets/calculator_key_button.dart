import 'package:flutter/material.dart';
import 'package:simple_calculator/src/constants/calculator_constants.dart';

class CalculatorKeyButton extends StatelessWidget {
  const CalculatorKeyButton({
    required this.label,
    required this.onPressed,
    this.isAccent = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isAccent;

  @override
  Widget build(BuildContext context) {
    final Widget child = label == CalculatorConstants.deleteKey
        ? const Icon(Icons.backspace_outlined)
        : Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isAccent ? Theme.of(context).colorScheme.primaryContainer : null,
      ),
      child: child,
    );
  }
}
