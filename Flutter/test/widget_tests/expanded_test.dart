// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Presentation/screens/ExpandedBooking.dart';
// import 'package:flutter_application_1/domain/bookingsClass.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   testWidgets('ExpandedBooking UI Test', (WidgetTester tester) async {
//     // Build our widget and trigger a frame.
//     await tester.pumpWidget(
//       ProviderScope(
//         child: MaterialApp(
//           home: ExpandedBooking(
//             arguments: ReservedTable(
//               guests: 4,
//               date: "2024-05-27",
//               time: "09:09AM",
//               type: "Type",
//               branch: "Branch",
//               food: "Food",
//               imageUrl: "assets/image.png",
//               tablesNum: 1,
//             ),
//           ),
//         ),
//       ),
//     );

//     // Verify that ExpandedBooking title is rendered
//     expect(find.text("Booking Details"), findsOneWidget);

//     // Verify that Modify Booking button is rendered
//     expect(find.text('Modify Booking'), findsOneWidget);

//     // You can add more tests to verify other UI elements as needed
//   });
// }
