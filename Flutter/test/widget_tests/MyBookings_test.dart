import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/widgets/My_bookingsState.dart';
import 'package:flutter_application_1/domain/bookingsClass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyBookings UI Test', (WidgetTester tester) async {
    await tester
        .pumpWidget(ProviderScope(child: MaterialApp(home: MyBookings())));

    expect(find.text('My Bookings'), findsOneWidget);

    expect(find.text('Current'), findsOneWidget);
    expect(find.text('Past'), findsOneWidget);
    expect(find.text('Canceled'), findsOneWidget);
  });
}
