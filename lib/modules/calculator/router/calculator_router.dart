import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/modules/calculator/bloc/calculator_bloc.dart';
import 'package:test_application/modules/calculator/interactor/calculator_interactor.dart';
import 'package:test_application/modules/calculator/view/calculator_view.dart';

class CalculatorRouter {
  static Widget createModule() {
    return BlocProvider(
      create: (context) => CalculatorBloc(CalculatorInteractor()),
      child: const CalculatorScreen(),
    );
  }
}
