import 'package:flutter/material.dart';
import 'package:test_application/modules/calculator/router/calculator_router.dart';
import 'package:test_application/dependency_injection.dart';

void main() {
  // Initialize Dependencies
  DependencyInjection.init();

  runApp(SafeArea(bottom: true, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CalculatorRouter.createModule(),
    );
  }
}
