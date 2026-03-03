import 'package:flutter_test/flutter_test.dart';
import 'package:simple_calculator/simple_calculator.dart';

void main() {
  test('evaluateExpression handles operator precedence', () {
    final CalculatorLogic logic = CalculatorLogic();

    final double result = logic.evaluateExpression('2 + 3 * 4');

    expect(result, 14);
  });

  test('onKeyPressed calculates expression', () {
    final CalculatorLogic logic = CalculatorLogic();

    for (final String key in <String>['1', '2', '+', '3', '=']) {
      logic.onKeyPressed(key);
    }

    expect(logic.result, '15');
    expect(logic.expression, '15');
  });

  test('calculate returns error on division by zero', () {
    final CalculatorLogic logic = CalculatorLogic();

    for (final String key in <String>['8', '/', '0', '=']) {
      logic.onKeyPressed(key);
    }

    expect(logic.result, 'Error');
  });

  test('C clears expression and result', () {
    final CalculatorLogic logic = CalculatorLogic();

    for (final String key in <String>['9', '+', '1']) {
      logic.onKeyPressed(key);
    }
    logic.onKeyPressed('C');

    expect(logic.expression, isEmpty);
    expect(logic.result, '0');
  });
}
