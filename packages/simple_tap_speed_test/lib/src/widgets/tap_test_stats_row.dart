import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TapTestStatsRow extends StatelessWidget {
  const TapTestStatsRow({
    super.key,
    required this.score,
    required this.remainingSeconds,
    required this.bestScore,
  });

  final int score;
  final int remainingSeconds;
  final int bestScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InfoTile(
            label: 'Score',
            value: score.toString(),
          ),
        ),
        const SizedBox(width: AppDimensions.spaceM),
        Expanded(
          child: InfoTile(
            label: 'Time',
            value: '${remainingSeconds}s',
          ),
        ),
        const SizedBox(width: AppDimensions.spaceM),
        Expanded(
          child: InfoTile(
            label: 'Best',
            value: bestScore.toString(),
          ),
        ),
      ],
    );
  }
}
