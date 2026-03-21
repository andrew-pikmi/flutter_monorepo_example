import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import '../logic/magic_8_ball_logic.dart';
import '../widgets/magic_8_ball_widget.dart';

class SimpleMagic8BallScreen extends StatefulWidget {
  const SimpleMagic8BallScreen({super.key});

  @override
  State<SimpleMagic8BallScreen> createState() => _SimpleMagic8BallScreenState();
}

class _SimpleMagic8BallScreenState extends State<SimpleMagic8BallScreen> {
  final Magic8BallLogic _logic = Magic8BallLogic();

  void _shakeBall() {
    setState(_logic.shake);
  }

  void _reset() {
    setState(_logic.reset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Magic 8 Ball'),
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Ask your question and shake the ball.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spaceL),
              Expanded(
                child: Magic8BallWidget(answer: _logic.answer),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              PrimaryButton(
                label: 'Shake',
                onPressed: _shakeBall,
              ),
              const SizedBox(height: AppDimensions.spaceM),
              PrimaryButton(
                label: 'Reset',
                onPressed: _reset,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
