import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/admin_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AdminPage UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: AdminPage(
            isDarkMode: false, // Set this to match your requirement
            toggleTheme: () {}, // Provide a mock function
          ),
        ),
      ),
    );

    // Verify that AdminPage title is rendered
    expect(find.text('Admin Page'), findsOneWidget);

    // Verify that Add Table section is rendered
    expect(find.text('Add Table'), findsOneWidget);
    expect(find.byKey(const Key("add1")), findsOneWidget);
    expect(find.byKey(const Key("add2")), findsOneWidget);
    expect(find.byKey(const Key("add3")), findsOneWidget);
    expect(find.byKey(const Key("add4")), findsOneWidget);
    expect(find.byKey(const Key("addbtn")), findsOneWidget);

    // Verify that Get Single Table section is rendered
    expect(find.text('Get Single Table'), findsOneWidget);
    expect(find.byKey(const Key("get")), findsOneWidget);
    expect(find.byKey(const Key("getbtn")), findsOneWidget);

    // Verify that Update Tables section is rendered
    expect(find.text('Update Tables'), findsOneWidget);
    expect(find.byKey(const Key("update1")), findsOneWidget);
    expect(find.byKey(const Key("update2")), findsOneWidget);
    expect(find.byKey(const Key("update3")), findsOneWidget);
    expect(find.byKey(const Key("update4")), findsOneWidget);
    expect(find.byKey(const Key("updatebtn")), findsOneWidget);

    // Verify that Delete Table section is rendered
    expect(find.text('Delete Table'), findsNWidgets(2));
    expect(find.byKey(const Key("delete")), findsOneWidget);
    expect(find.byKey(const Key("deletebtn")), findsOneWidget);
  });
}
