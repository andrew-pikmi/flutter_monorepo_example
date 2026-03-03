import 'package:flutter/material.dart';
import 'package:simple_calculator/simple_calculator.dart';
import 'package:ui_kit/ui_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openCalculator(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const CalculatorScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Simple Things App'),
      body: Center(
        child: Column(
          children: <Widget>[
            PrimaryButton(
              label: 'Simple Calculator',
              onPressed: () => _openCalculator(context),
            ),
          ],
        ),
      ),
    );
  }
}
