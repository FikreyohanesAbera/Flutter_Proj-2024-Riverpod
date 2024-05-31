// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Presentation/screens/signup_page.dart';
// import 'package:flutter_application_1/Presentation/widgets/username.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flutter_application_1/application/Providers/signup_provider.dart';

// // Mock class for the SignupStateProvider
// class MockSignupStateProvider extends Mock implements SignupStateProvider {}

// void main() {
//   group('SignupPage', () {
//     // Define a mock SignupStateProvider
//     MockSignupStateProvider mockSignupStateProvider;

//     setUp(() {
//       // Initialize the mock object
//       mockSignupStateProvider = MockSignupStateProvider();
//     });

//     testWidgets('Renders signup page correctly', (WidgetTester tester) async {
//       // Build our widget
//       await tester.pumpWidget(MaterialApp(
//         home: SignupPage(),
//         // Provide the mock SignupStateProvider
//         overrides: [
//           signupStateProvider.overrideWithProvider(
//             Provider((ref) => mockSignupStateProvider),
//           ),
//         ],
//       ));

//       // Verify that the signup page renders correctly
//       expect(find.text('Sign up'), findsOneWidget);
//       expect(find.text('Create your account'), findsOneWidget);
//       // Add more expectations as needed
//     });

//     testWidgets('Signup button triggers signup process',
//         (WidgetTester tester) async {
//       // Build our widget
//       await tester.pumpWidget(MaterialApp(
//         home: SignupPage(),
//         // Provide the mock SignupStateProvider
//         overrides: [
//           signupStateProvider.overrideWithProvider(
//             Provider((ref) => mockSignupStateProvider),
//           ),
//         ],
//       ));

//       // Simulate entering data into the text fields
//       await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
//       await tester.enterText(find.byType(TextField).at(1), 'password');
//       await tester.enterText(find.byType(TextField).at(2), 'password');
//       await tester.enterText(find.byType(UsernameTextField), 'testuser');

//       // Tap the signup button
//       await tester.tap(find.text('Sign up'));
//       // Wait for the UI to react
//       await tester.pump();

//       // Verify that the signup process is triggered
//       verify(mockSignupStateProvider.signup(any, any, any)).called(1);
//       // Add more verifications as needed
//     });
//   });
// }
