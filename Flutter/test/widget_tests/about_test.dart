import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/about.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AboutPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AboutPage()));

    expect(find.text('Traditional Booking'), findsOneWidget);

    expect(find.byType(CircleAvatar), findsOneWidget);

    expect(find.text('About us'), findsOneWidget);

    expect(find.text('Explore now'), findsOneWidget);
  });
}
