import 'package:flutter_application_1/infrastructure/table_repository.dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class TableState extends StateNotifier<Map<String, String>> {
  TableState() : super({});

  Future<void> table(ref, String seats, String type, String floor,
      String tableNUM, String method) async {
    try {
      final Map<String, String> result = await TableService(Client())
          .table(ref, type, floor, tableNUM, seats, method);
      state = result;
    } catch (error) {
      state = {"error": error.toString()};
    }
  }
}
