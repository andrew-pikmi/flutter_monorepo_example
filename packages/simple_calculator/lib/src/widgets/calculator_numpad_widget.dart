import 'package:flutter/material.dart';
import 'package:simple_calculator/src/constants/calculator_constants.dart';
import 'package:simple_calculator/src/widgets/calculator_key_button.dart';
import 'package:ui_kit/ui_kit.dart';

class CalculatorNumpadWidget extends StatelessWidget {
  const CalculatorNumpadWidget({
    required this.layout,
    required this.onKeyPressed,
    super.key,
  });

  final List<List<String>> layout;
  final ValueChanged<String> onKeyPressed;

  @override
  Widget build(BuildContext context) {
    final List<String> flatKeys =
        layout.expand((List<String> row) => row).toList(growable: false);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: flatKeys.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: layout.first.length,
        mainAxisSpacing: AppDimensions.spaceS,
        crossAxisSpacing: AppDimensions.spaceS,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (BuildContext context, int index) {
        final String key = flatKeys[index];
        return CalculatorKeyButton(
          label: key,
          isAccent: CalculatorConstants.accentKeys.contains(key),
          onPressed: () => onKeyPressed(key),
        );
      },
    );
  }
}
