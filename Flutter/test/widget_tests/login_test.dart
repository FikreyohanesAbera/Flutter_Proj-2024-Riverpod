import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);

    expect(find.byType(TextField), findsNWidgets(2)); // Two TextFields
    expect(find.text('Email'), findsOneWidget);

    expect(find.text('Password'), findsOneWidget);

    expect(find.text('Login'), findsOneWidget);

    expect(find.text('Forgot password?'), findsOneWidget);

    expect(find.text("Sign Up"), findsOneWidget);
  });
}
