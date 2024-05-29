import 'package:flutter/material.dart';
import '../widgets/reservation_form_page.dart';

class MainReserve extends StatelessWidget {
  final String data;
  MainReserve({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReservationFormPage(data: data),
    );
  }
}
