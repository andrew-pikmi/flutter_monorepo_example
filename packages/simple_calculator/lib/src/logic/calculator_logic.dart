import 'package:simple_calculator/src/constants/calculator_constants.dart';

class CalculatorLogic {
  String expression = '';
  String result = '0';

  void onKeyPressed(String key) {
    if (key == CalculatorConstants.clearKey) {
      clear();
      return;
    }

    if (key == CalculatorConstants.deleteKey) {
      deleteOneSymbol();
      return;
    }

    if (key == CalculatorConstants.equalsKey) {
      calculate();
      return;
    }

    if (key == CalculatorConstants.signToggleKey) {
      toggleSign();
      return;
    }

    if (key == CalculatorConstants.percentKey) {
      applyPercent();
      return;
    }

    if (key == CalculatorConstants.decimalSeparator) {
      appendDecimalSeparator();
      return;
    }

    if (CalculatorConstants.operators.contains(key)) {
      _appendOperator(key);
      return;
    }

    expression += key;
  }

  void clear() {
    expression = '';
    result = '0';
  }

  void deleteOneSymbol() {
    if (expression.isEmpty) {
      return;
    }

    if (expression.endsWith(' ') && expression.length >= 3) {
      expression = expression.substring(0, expression.length - 3);
      return;
    }

    expression = expression.substring(0, expression.length - 1);
  }

  void toggleSign() {
    if (expression.isEmpty) {
      expression = CalculatorConstants.minus;
      return;
    }

    if (expression.endsWith(' ')) {
      expression += CalculatorConstants.minus;
      return;
    }

    final int tokenStart = expression.lastIndexOf(' ') + 1;
    final String token = expression.substring(tokenStart);

    if (token == CalculatorConstants.minus) {
      expression = expression.substring(0, tokenStart);
      return;
    }

    if (token.startsWith(CalculatorConstants.minus)) {
      expression =
          '${expression.substring(0, tokenStart)}${token.substring(1)}';
      return;
    }

    expression = '${expression.substring(0, tokenStart)}-$token';
  }

  void applyPercent() {
    final int tokenStart = expression.lastIndexOf(' ') + 1;
    if (tokenStart >= expression.length) {
      return;
    }

    final String token = expression.substring(tokenStart);
    if (CalculatorConstants.operators.contains(token)) {
      return;
    }

    final double? parsed = double.tryParse(
      token.replaceAll(
        CalculatorConstants.decimalSeparator,
        '.',
      ),
    );

    if (parsed == null) {
      return;
    }

    final String percentValue = _formatNumber(parsed / 100);
    expression = '${expression.substring(0, tokenStart)}$percentValue';
  }

  void appendDecimalSeparator() {
    if (expression.isEmpty) {
      expression = '0${CalculatorConstants.decimalSeparator}';
      return;
    }

    if (expression.endsWith(' ')) {
      expression += '0${CalculatorConstants.decimalSeparator}';
      return;
    }

    final int tokenStart = expression.lastIndexOf(' ') + 1;
    final String token = expression.substring(tokenStart);

    if (CalculatorConstants.operators.contains(token)) {
      expression += '0${CalculatorConstants.decimalSeparator}';
      return;
    }

    if (token == CalculatorConstants.minus) {
      expression += '0${CalculatorConstants.decimalSeparator}';
      return;
    }

    if (token.contains(CalculatorConstants.decimalSeparator)) {
      return;
    }

    expression += CalculatorConstants.decimalSeparator;
  }

  void calculate() {
    final String trimmedExpression = expression.trim();
    if (trimmedExpression.isEmpty) {
      return;
    }

    final String lastToken = trimmedExpression.split(RegExp(r'\s+')).last;
    if (CalculatorConstants.operators.contains(lastToken) ||
        lastToken == CalculatorConstants.minus) {
      return;
    }

    try {
      final double value = evaluateExpression(trimmedExpression);
      result = _formatNumber(value);
      expression = result;
    } on Exception {
      result = 'Error';
    }
  }

  double evaluateExpression(String expressionValue) {
    final List<String> tokens = expressionValue.split(RegExp(r'\s+'));
    final List<double> values = <double>[];
    final List<String> ops = <String>[];

    int precedence(String op) {
      if (op == CalculatorConstants.plus || op == CalculatorConstants.minus) {
        return 1;
      }
      if (op == CalculatorConstants.multiply ||
          op == CalculatorConstants.divide) {
        return 2;
      }
      throw FormatException('Unknown operator: $op');
    }

    void applyTopOperator() {
      if (values.length < 2 || ops.isEmpty) {
        throw const FormatException('Invalid expression');
      }

      final double right = values.removeLast();
      final double left = values.removeLast();
      final String op = ops.removeLast();

      switch (op) {
        case CalculatorConstants.plus:
          values.add(left + right);
          break;
        case CalculatorConstants.minus:
          values.add(left - right);
          break;
        case CalculatorConstants.multiply:
          values.add(left * right);
          break;
        case CalculatorConstants.divide:
          if (right == 0) {
            throw const FormatException('Division by zero');
          }
          values.add(left / right);
          break;
      }
    }

    for (final String token in tokens) {
      if (CalculatorConstants.operators.contains(token)) {
        while (ops.isNotEmpty && precedence(ops.last) >= precedence(token)) {
          applyTopOperator();
        }
        ops.add(token);
      } else {
        final double? parsed = double.tryParse(
          token.replaceAll(CalculatorConstants.decimalSeparator, '.'),
        );
        if (parsed == null) {
          throw FormatException('Invalid token: $token');
        }
        values.add(parsed);
      }
    }

    while (ops.isNotEmpty) {
      applyTopOperator();
    }

    if (values.length != 1) {
      throw const FormatException('Invalid expression');
    }

    return values.single;
  }

  void _appendOperator(String key) {
    final String trimmed = expression.trimRight();
    if (trimmed.isEmpty) {
      return;
    }

    final String currentToken = trimmed.substring(trimmed.lastIndexOf(' ') + 1);
    if (currentToken == CalculatorConstants.minus) {
      return;
    }

    final String lastChar = trimmed[trimmed.length - 1];
    if (CalculatorConstants.operators.contains(lastChar)) {
      expression = '${trimmed.substring(0, trimmed.length - 1)}$key ';
      return;
    }

    expression = '$trimmed $key ';
  }

  String _formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value
        .toString()
        .replaceAll('.', CalculatorConstants.decimalSeparator);
  }
}
