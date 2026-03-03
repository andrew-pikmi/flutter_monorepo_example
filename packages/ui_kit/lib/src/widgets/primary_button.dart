import 'package:flutter/material.dart';
import 'package:ui_kit/src/utils/dimensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: AppDimensions.primaryButtonPadding,
      ),
      child: Text(label),
    );
  }
}
