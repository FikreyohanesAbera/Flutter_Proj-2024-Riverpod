import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/main_reserve.dart';
import 'package:flutter_application_1/Presentation/widgets/date_field.dart';
import 'package:flutter_application_1/Presentation/widgets/number_of_people.dart';
import 'package:flutter_application_1/Presentation/widgets/reserve.dart';
import 'package:flutter_application_1/Presentation/widgets/time_field.dart';
import 'package:flutter_application_1/application/Providers/reserveProvider.dart';
import 'package:flutter_application_1/application/Providers/userProvider.dart';
import 'package:flutter_application_1/application/states/reserve_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Mock the providers and dependencies
  // final mockUserProvider = StateProvider<String>((ref) => '');
  // final mockIsConfirmingProvider = StateProvider<bool>((ref) => false);
  // final mockReserveStateProvider =
  //     StateProvider<Map<String, dynamic>>((ref) => {});
  // final mockNumberOfPeopleController = TextEditingController();
  // final mockDateController = TextEditingController();
  // final mockTimeController = TextEditingController();
  // final mockOnTypeSelected = (bool isSelected, String type) {};
  // final mockOnBranchSelected = (bool isSelected, String branch) {};

  testWidgets('ReservationForm widget test', (WidgetTester tester) async {
    // Build the ReservationForm widget with mocked dependencies
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userProvider.overrideWith(((ref) => "")),
          isConfirmingProvider.overrideWith((ref) => false),
          reserveStateProvider.overrideWith((ref) => ReserveState()),
        ],
        child: MaterialApp(
          home: MainReserve(
              checkTime: "", create: "true", tableNumber: "4", data: ""),
        ),
      ),
    );

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(NumberOfPeopleField), findsOneWidget);
    expect(find.byType(DateField), findsOneWidget);
    expect(find.byType(TimeField), findsOneWidget);
    expect(find.text('Type'), findsOneWidget);
    expect(find.text('Branch'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
