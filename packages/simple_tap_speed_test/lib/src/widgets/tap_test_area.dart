import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import '../constants/speed_test_constants.dart';

class TapTestArea extends StatelessWidget {
  const TapTestArea({
    super.key,
    required this.isRunning,
    required this.onTap,
  });

  final bool isRunning;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: SpeedTestConstants.tapAreaAnimationMs,
        ),
        decoration: BoxDecoration(
          color: isRunning
              ? colors.primaryContainer
              : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusL),
        ),
        child: Center(
          child: Text(
            isRunning ? 'TAP' : 'PRESS START',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
