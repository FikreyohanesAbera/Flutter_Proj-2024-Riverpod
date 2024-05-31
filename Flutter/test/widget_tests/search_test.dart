import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

// Mock GoRouter
class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockGoRouter mockRouter;

  setUp(() {
    mockRouter = MockGoRouter();
  });

  testWidgets('Search widget UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Search(),
      ),
    );

    expect(find.text("Search"), findsOneWidget);

    expect(find.byType(TextField), findsOneWidget);

    expect(find.text("Popular feasts"), findsOneWidget);
  });
}
