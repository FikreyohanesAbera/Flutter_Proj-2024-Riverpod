import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/ExpandedBooking.dart';
import 'package:flutter_application_1/Presentation/screens/HomePage.dart';
import 'package:flutter_application_1/Presentation/screens/admin_page.dart';
import 'package:flutter_application_1/Presentation/screens/login_page.dart';
import 'package:flutter_application_1/Presentation/screens/main_reserve.dart';
import 'package:flutter_application_1/infrastructure/auth_repository.dart';
import 'package:http/http.dart';
import "package:integration_test/integration_test.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/Presentation/screens/navigator.dart'
    as app;
import 'package:mocktail/mocktail.dart';

class MockHTTPClient extends Mock implements Client {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AuthService authService;
  late MockHTTPClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    authService = AuthService(mockHTTPClient);
  });
  group("integration testing for reservation", () {
    testWidgets("intro", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.text("Let's Start"));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(find.byType(LoginPage), findsOneWidget);
    });
    testWidgets("login", (tester) async {
      app.main();

      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.enterText(
          find.byKey(const Key("loginEmail")), "g@gmail.com");
      Future.delayed(const Duration(seconds: 1));

      await tester.enterText(find.byKey(const Key("loginPassword")), "a");
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("loginButton")));
      await Future.delayed(const Duration(seconds: 1));

      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      ///////////////////////////////////

      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.search_sharp));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("Pastaitem")));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.byType(MainReserve), findsOneWidget);

      ////////////////////////////////////////////
      ///
      await tester.enterText(find.byKey(const Key("numberofpeople")), "4");
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("dateInput")));
      await tester.pumpAndSettle();

      final datePickerDialogFinder = find.byType(Dialog);
      expect(datePickerDialogFinder, findsOneWidget);

      await tester.tap(find.text("8"));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      // await tester.enterText(find.byKey(const Key("dateInput")), "2024-06-05");
      // Future.delayed(const Duration(seconds: 1));
      // await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("timeInput")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      // await tester.tap(find.text("4"));
      // await tester.pumpAndSettle();

      // await tester.tap(find.text("OK"));
      // await tester.pumpAndSettle();

      Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key("typeChip")));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("branchChip")));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("confirmBooking")));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);

      ///////////////////////////////////////

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("backToHomeFromReserve")));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.date_range_outlined));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.text("View Reservation").at(0));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(find.byType(ExpandedBooking), findsOneWidget);

      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.text("Modify Booking"));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(find.byType(MainReserve), findsOneWidget);

      /////////////////////////////////////

      await tester.enterText(find.byKey(const Key("numberofpeople")), "4");
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("dateInput")));
      await tester.pumpAndSettle();

      final datePickerDialogFinder2 = find.byType(Dialog);
      expect(datePickerDialogFinder2, findsOneWidget);

      await tester.tap(find.text("8"));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      // await tester.enterText(find.byKey(const Key("dateInput")), "2024-06-05");
      // Future.delayed(const Duration(seconds: 1));
      // await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("timeInput")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      // await tester.tap(find.text("4"));
      // await tester.pumpAndSettle();

      // await tester.tap(find.text("OK"));
      // await tester.pumpAndSettle();

      Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key("typeChip")));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("branchChip")));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("confirmBooking")));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);

      ///////////////////////////////////////

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("backToHomeFromReserve")));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);

      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byIcon(Icons.date_range_outlined));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.text("Cancel Reservation").at(0));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      ///////////////////////////

      await tester.tap(find.byIcon(Icons.person_rounded));
      Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Edit Profile"));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.enterText(find.byKey(const Key("changeName")), "NewName");
      await tester.pumpAndSettle();

      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("namechangeButton")));
      await tester.pumpAndSettle();

      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("backToProfile")));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(find.text("NewName"), findsOneWidget);
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(Key("logout")));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      await tester.tap(find.byKey(const Key("adminChoice")));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key("loginEmail")), "Abebe");
      Future.delayed(const Duration(seconds: 1));

      await tester.enterText(
          find.byKey(const Key("loginPassword")), "tablereserve");
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("loginButton")));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));

      expect(find.byType(AdminPage), findsOneWidget);

      await tester.enterText(find.byKey(const Key("add1")), "55");
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("add2")), "20");
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("add3")), "6");
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("add4")), "Business");
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Verify that the keyboard is dismissed
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(tester.testTextInput.editingState, isNull);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("addbtn")));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);

      Future.delayed(const Duration(seconds: 1));
      await tester.enterText(find.byKey(const Key("get")), "1");
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Verify that the keyboard is dismissed
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(tester.testTextInput.editingState, isNull);
      await Future.delayed(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key("getbtn")));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));

      expect(find.byType(Dialog), findsOneWidget);
      await tester.tap(find.text("Close"));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.enterText(find.byKey(const Key("update1")), "55");
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("update2")), "22");
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("update3")), "Business");
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("update4")), "5");
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Verify that the keyboard is dismissed
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(tester.testTextInput.editingState, isNull);
      await tester.tap(find.byKey(const Key("updatebtn")));
      await tester.pumpAndSettle();

      Future.delayed(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);

      await tester.enterText(find.byKey(const Key("delete")), "5");
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Verify that the keyboard is dismissed
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(tester.testTextInput.editingState, isNull);
      await tester.tap(find.byKey(const Key("deletebtn")));
      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      expect(find.byType(SnackBar), findsOneWidget);

      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("loginfromadmin")));
      await tester.pumpAndSettle();

      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));

      await tester.enterText(
          find.byKey(const Key("loginEmail")), "non@gmail.com");
      Future.delayed(const Duration(seconds: 1));

      await tester.enterText(find.byKey(const Key("loginPassword")), "a");
      Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key("loginButton")));
      Future.delayed(const Duration(seconds: 1));

      await tester.pumpAndSettle();
      Future.delayed(const Duration(seconds: 1));
      expect(find.byType(SnackBar), findsOneWidget);
    });
    // testWidgets("login failure", (tester) async {
    //   app.main();

    // });
  });
}
