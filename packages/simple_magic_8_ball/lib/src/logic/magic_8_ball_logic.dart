import 'dart:math';

import '../constants/magic_8_ball_constants.dart';

class Magic8BallLogic {
  Magic8BallLogic({Random? random}) : _random = random ?? Random();

  final Random _random;

  String _answer = Magic8BallConstants.initialAnswer;

  String get answer => _answer;

  void shake() {
    _answer = Magic8BallConstants.answers[_random.nextInt(
      Magic8BallConstants.answers.length,
    )];
  }

  void reset() {
    _answer = Magic8BallConstants.initialAnswer;
  }
}
