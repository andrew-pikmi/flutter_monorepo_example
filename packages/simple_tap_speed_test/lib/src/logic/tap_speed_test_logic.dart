import 'package:simple_tap_speed_test/src/constants/speed_test_constants.dart';

enum TapSpeedTestStatus { idle, running, finished }

class TapSpeedTestLogic {
  TapSpeedTestLogic({
    this.durationSeconds = SpeedTestConstants.defaultDurationSeconds,
  }) : remainingSeconds = durationSeconds;

  final int durationSeconds;

  int score = 0;
  int bestScore = 0;
  int remainingSeconds;
  TapSpeedTestStatus status = TapSpeedTestStatus.idle;

  bool get isRunning => status == TapSpeedTestStatus.running;
  bool get isFinished => status == TapSpeedTestStatus.finished;

  void start() {
    score = 0;
    remainingSeconds = durationSeconds;
    status = TapSpeedTestStatus.running;
  }

  void registerTap() {
    if (!isRunning) {
      return;
    }

    score++;
  }

  void tick() {
    if (!isRunning) {
      return;
    }

    if (remainingSeconds > 0) {
      remainingSeconds--;
    }

    if (remainingSeconds == 0) {
      _finish();
    }
  }

  void reset() {
    score = 0;
    remainingSeconds = durationSeconds;
    status = TapSpeedTestStatus.idle;
  }

  void _finish() {
    if (score > bestScore) {
      bestScore = score;
    }

    status = TapSpeedTestStatus.finished;
  }
}
