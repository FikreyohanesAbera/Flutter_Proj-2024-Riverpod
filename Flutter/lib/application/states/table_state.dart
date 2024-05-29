import 'package:flutter_application_1/application/table_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';

class TableState extends StateNotifier<Map<String, String>> {
  TableState() : super({});

  Future<void> table(ref, String seats, String type, String floor,
      String tableNUM, String method) async {
    print("yess");
    print(tableNUM);
    try {
      final Map<String, String> result =
          await TableService.table(ref, type, floor, tableNUM, seats, method);
      state = result;
    } catch (error) {
      state = {"error": error.toString()};
    }
  }
}
