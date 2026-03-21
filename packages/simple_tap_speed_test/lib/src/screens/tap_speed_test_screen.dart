import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import '../constants/speed_test_constants.dart';
import '../logic/tap_speed_test_logic.dart';
import '../widgets/tap_test_area.dart';
import '../widgets/tap_test_headline.dart';
import '../widgets/tap_test_stats_row.dart';

class SimpleTapSpeedTestScreen extends StatefulWidget {
  const SimpleTapSpeedTestScreen({super.key});

  @override
  State<SimpleTapSpeedTestScreen> createState() =>
      _SimpleTapSpeedTestScreenState();
}

class _SimpleTapSpeedTestScreenState extends State<SimpleTapSpeedTestScreen> {
  final TapSpeedTestLogic _logic = TapSpeedTestLogic();

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startRound() {
    _timer?.cancel();

    setState(() {
      _logic.start();
    });

    _timer = Timer.periodic(
      const Duration(seconds: SpeedTestConstants.timerTickSeconds),
      (Timer timer) {
        setState(() {
          _logic.tick();
        });

        if (!_logic.isRunning) {
          timer.cancel();
        }
      },
    );
  }

  void _resetRound() {
    _timer?.cancel();
    setState(_logic.reset);
  }

  void _handleTap() {
    setState(_logic.registerTap);
  }

  String get _headline {
    switch (_logic.status) {
      case TapSpeedTestStatus.idle:
        return 'Ready to test your speed?';
      case TapSpeedTestStatus.running:
        return 'Tap as fast as you can';
      case TapSpeedTestStatus.finished:
        return 'Time is up';
    }
  }

  String get _actionLabel {
    if (_logic.isFinished) {
      return 'Try Again';
    }

    if (_logic.isRunning) {
      return 'Reset';
    }

    return 'Start Test';
  }

  VoidCallback get _action {
    if (_logic.isRunning) {
      return _resetRound;
    }

    return _startRound;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Tap Speed Test'),
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TapTestHeadline(text: _headline),
              const SizedBox(height: AppDimensions.spaceL),
              TapTestStatsRow(
                score: _logic.score,
                remainingSeconds: _logic.remainingSeconds,
                bestScore: _logic.bestScore,
              ),
              const SizedBox(height: AppDimensions.spaceL),
              Expanded(
                child: TapTestArea(
                  isRunning: _logic.isRunning,
                  onTap: _logic.isRunning ? _handleTap : null,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              PrimaryButton(label: _actionLabel, onPressed: _action),
            ],
          ),
        ),
      ),
    );
  }
}
