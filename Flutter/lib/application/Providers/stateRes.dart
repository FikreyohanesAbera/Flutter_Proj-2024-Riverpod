import 'package:flutter_application_1/domain/bookingsClass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentTablesProvider = StateProvider<List<ReservedTable>>((ref) {
  return [];
});

final pastTablesProvider = StateProvider<List<ReservedTable>>((ref) {
  return [];
});

final canceledTablesProvider = StateProvider<List<ReservedTable>>((ref) {
  return [];
});
