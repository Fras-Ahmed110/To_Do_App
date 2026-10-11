import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/main.dart';

void main() {
  testWidgets('To-Do app smoke test - add, toggle, and delete task', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify empty state is shown initially
    expect(find.text('No tasks yet!'), findsOneWidget);

    // Enter a new task title
    await tester.enterText(find.byType(TextField), 'Study Flutter');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify task is added and empty state is hidden
    expect(find.text('No tasks yet!'), findsNothing);
    expect(find.text('Study Flutter'), findsOneWidget);

    // Checkbox is empty before completion (no check icon)
    expect(find.byIcon(Icons.check), findsNothing);

    // Tap task item text to toggle task completed state
    await tester.tap(find.text('Study Flutter'));
    await tester.pumpAndSettle();

    // Now check icon should be visible
    expect(find.byIcon(Icons.check), findsOneWidget);

    // Delete the task
    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();

    // Verify list is empty again
    expect(find.text('No tasks yet!'), findsOneWidget);
    expect(find.text('Study Flutter'), findsNothing);
  });
}
