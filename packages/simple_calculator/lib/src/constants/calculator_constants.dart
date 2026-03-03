abstract final class CalculatorConstants {
  static const String plus = '+';
  static const String minus = '-';
  static const String multiply = '*';
  static const String divide = '/';

  static const String clearKey = 'C';
  static const String deleteKey = 'DEL';
  static const String equalsKey = '=';
  static const String percentKey = '%';
  static const String signToggleKey = '+/-';
  static const String decimalSeparator = ',';

  static const Set<String> operators = <String>{plus, minus, multiply, divide};

  static const Set<String> unaryKeys = <String>{
    clearKey,
    deleteKey,
    percentKey,
    signToggleKey,
  };

  static const Set<String> accentKeys = <String>{
    ...operators,
    equalsKey,
    ...unaryKeys,
  };

  static const List<List<String>> defaultNumpadLayout = <List<String>>[
    <String>[deleteKey, clearKey, percentKey, divide],
    <String>['7', '8', '9', multiply],
    <String>['4', '5', '6', minus],
    <String>['1', '2', '3', plus],
    <String>[
      signToggleKey,
      '0',
      decimalSeparator,
      equalsKey,
    ],
  ];
}
