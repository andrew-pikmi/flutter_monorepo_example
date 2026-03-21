import 'dart:math';

import '../constants/magic_8_ball_constants.dart';

class Magic8BallLogic {
  Magic8BallLogic({Random? random}) : _random = random ?? Random();

  final Random _random;

  String _answer = Magic8BallConstants.initialAnswer;

  String get answer => _answer;

  void shake() {
    final availableAnswers = Magic8BallConstants.answers
        .where((answer) => answer != _answer)
        .toList(growable: false);

    if (availableAnswers.isEmpty) {
      return;
    }

    _answer = availableAnswers[_random.nextInt(availableAnswers.length)];
  }

  void reset() {
    _answer = Magic8BallConstants.initialAnswer;
  }
}
