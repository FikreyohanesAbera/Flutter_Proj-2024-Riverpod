import 'package:flutter_application_1/application/reserve_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReserveState extends StateNotifier<Map<String, String>> {
  ReserveState() : super({});

  Future<Map<String, String>> reserve(ref, String seatsH, String date,
      String time, String typeH, String branch, String foodName) async {
    try {
      final Map<String, String> result = await ReserveService.reserve(
          ref, seatsH, date, time, typeH, branch, foodName);
      state = result;
    } catch (error) {
      state = {"error": error.toString()};
    }
    return {};
  }
}
