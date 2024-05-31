import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/signup_page.dart';
import 'package:flutter_application_1/application/states/signup_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/application/Providers/signup_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import your SignupPage widget

void main() {
  testWidgets('Signup page renders correctly', (tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SignupPage(),
        ),
      ),
    );

    expect(find.text('Sign up'), findsOneWidget);

    expect(find.byType(TextField), findsNWidgets(4)); // 3 text fields present

    expect(find.text('Sign In with Google'), findsOneWidget);
  });

  testWidgets('Sign up button triggers sign up process',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SignupPage(),
        ),
      ),
    );

    await tester.tap(find.text('Sign up'));

    await tester.pumpAndSettle();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          SignupStateProvider.overrideWith((ref) => SignupState()),
        ],
        child: const SignupPage(),
      ),
    );
  });
}
