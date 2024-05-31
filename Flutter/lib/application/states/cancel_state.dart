import 'package:flutter_application_1/infrastructure/cancel_repository.dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CancelState extends StateNotifier<Map<String, String>> {
  CancelState() : super({});

  Future<void> cancel(ref, String time, int tablesNum) async {
    print("yess");
    try {
      final Map<String, String> result =
          await CancelService.cancel(ref, time, tablesNum);
      state = result;
    } catch (error) {
      state = {"error": error.toString()};
    }
  }
}
