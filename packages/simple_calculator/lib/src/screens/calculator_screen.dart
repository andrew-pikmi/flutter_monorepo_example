import 'package:flutter/material.dart';
import 'package:simple_calculator/src/constants/calculator_constants.dart';
import 'package:simple_calculator/src/logic/calculator_logic.dart';
import 'package:simple_calculator/src/widgets/calculator_numpad_widget.dart';
import 'package:ui_kit/ui_kit.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _logic = CalculatorLogic();

  void _onKeyPressed(String key) {
    setState(() {
      _logic.onKeyPressed(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Calculator'),
      body: SafeArea(
        child: Padding(
          padding: AppDimensions.screenPadding,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        _logic.expression.isEmpty ? '0' : _logic.expression,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      Text(
                        '= ${_logic.result}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceL),
              CalculatorNumpadWidget(
                layout: CalculatorConstants.defaultNumpadLayout,
                onKeyPressed: _onKeyPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
