import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_application/application/calculator_provider.dart';
import 'package:test_application/presentation/calculator_screen.dart';
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
    return ChangeNotifierProvider(
      create: (context) {
        return CalculatorProvider();
      },
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          home: CalculatorScreen(),
        );
      },
    );
  }
}
