import 'dart:convert';

import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_application_1/domain/bookingsClass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

final userResProvider =
    FutureProvider.family<List<ReservedTable>, String>((ref, id) async {
  final List<ReservedTable> data = await fetchDataFromBackend(ref, id);
  return data;
});

Future<List<ReservedTable>> fetchDataFromBackend(ref, String id) async {
  print("hello");
  print(ref.read(tokenProvider.notifier).state);

  final response = await http.get(
      Uri.parse("http://192.168.1.110:5000/reserve/userreservations"),
      headers: {"token": ref.read(tokenProvider.notifier).state});
  print(response.statusCode);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    final jsonData = jsonDecode(response.body) as List<dynamic>;
    print(jsonData);
    final List<ReservedTable> data = jsonData
        .map((item) => ReservedTable(
            item['Number_of_people'],
            item['date'],
            item['time'],
            item['Type'],
            item['food'],
            item['branch'],
            item['tableNumber']))
        .toList();
    return data;
  } else {
    throw Exception('Failed to load data from backend');
  }
}
