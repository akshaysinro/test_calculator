import 'package:flutter_test/flutter_test.dart';
import 'package:test_application/infrastrucure/operation/add_operation.dart';
import 'package:test_application/infrastrucure/operation/divide_operator.dart';
import 'package:test_application/infrastrucure/operation/minus_operation.dart';
import 'package:test_application/infrastrucure/operation/multiply_operation.dart';
import 'package:test_application/infrastrucure/operation/operation_factory.dart';
import 'package:test_application/main.dart'; // Imports MyApp

// We can integration test the whole app since logic is inside modules

void main() {
  setUpAll(() {
    // Ensure factory is initialized for the tests
    OperationFactory.register('+', AddOperation());
    OperationFactory.register('-', MinusOperation());
    OperationFactory.register('×', MultiplyOperation());
    OperationFactory.register('÷', DivideOperator());
  });

  testWidgets('Calculator App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify initial state
    expect(find.text('0'), findsOneWidget);

    // Perform 1 + 2 =
    await tester.tap(find.text('1')); // Tap 1
    await tester.pump();

    await tester.tap(find.text('+')); // Tap +
    await tester.pump();

    await tester.tap(find.text('2')); // Tap 2
    await tester.pump();

    await tester.tap(find.text('=')); // Tap =
    await tester.pump();

    // Verify result 3
    // Note: With BLoC/Stream, multiple pumps might be needed if async,
    // but here it's synchronous logic in the blocs so standard pumps usually work.
    expect(find.text('3'), findsOneWidget);
  });
}
