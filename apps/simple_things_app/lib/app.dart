import 'package:flutter/material.dart';
import 'package:simple_things_app/screens/home_screen.dart';

class SimpleThingsApp extends StatelessWidget {
  const SimpleThingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Things',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
