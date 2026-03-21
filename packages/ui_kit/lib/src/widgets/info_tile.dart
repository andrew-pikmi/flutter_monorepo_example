import 'package:flutter/material.dart';
import 'package:ui_kit/src/utils/dimensions.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    required this.label,
    required this.value,
    this.borderRadius = AppDimensions.borderRadiusM,
    super.key,
  });

  final String label;
  final String value;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          children: <Widget>[
            Text(label),
            const SizedBox(height: AppDimensions.spaceS),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
