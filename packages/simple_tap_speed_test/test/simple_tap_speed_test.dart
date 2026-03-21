import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tap_speed_test/simple_tap_speed_test.dart';

void main() {
  test('start resets score and starts timer', () {
    final TapSpeedTestLogic logic = TapSpeedTestLogic(durationSeconds: 5);

    logic.score = 3;
    logic.start();

    expect(logic.score, 0);
    expect(logic.remainingSeconds, 5);
    expect(logic.isRunning, isTrue);
  });

  test('registerTap increments only while running', () {
    final TapSpeedTestLogic logic = TapSpeedTestLogic();

    logic.registerTap();
    expect(logic.score, 0);

    logic.start();
    logic.registerTap();
    logic.registerTap();

    expect(logic.score, 2);
  });

  test('tick finishes round and stores best score', () {
    final TapSpeedTestLogic logic = TapSpeedTestLogic(durationSeconds: 2);

    logic.start();
    logic.registerTap();
    logic.registerTap();
    logic.tick();
    logic.tick();

    expect(logic.isFinished, isTrue);
    expect(logic.bestScore, 2);
    expect(logic.remainingSeconds, 0);
  });
}
