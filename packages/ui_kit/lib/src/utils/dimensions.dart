import 'package:flutter/widgets.dart';

abstract final class AppDimensions {
  static const double spaceS = 8;
  static const double spaceM = 12;
  static const double spaceL = 16;

  static const EdgeInsets screenPadding = EdgeInsets.all(spaceL);
  static const EdgeInsets primaryButtonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 14,
  );
}
