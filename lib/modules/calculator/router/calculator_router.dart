import 'package:flutter/material.dart';
import 'package:test_application/modules/calculator/interactor/calculator_interactor.dart';
import 'package:test_application/modules/calculator/presenter/calculator_presenter.dart';
import 'package:test_application/presentation/calculator_screen.dart'; // We will move this next

class CalculatorRouter {
  static Widget createModule() {
    return CalculatorScreen(
      presenterBuilder: (view) {
        final interactor = CalculatorInteractor();
        return CalculatorPresenter(view, interactor);
      },
    );
  }
}
