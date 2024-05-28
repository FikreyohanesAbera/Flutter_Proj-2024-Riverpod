import 'package:flutter_application_1/application/states/login_state.dart';
import 'package:flutter_application_1/application/states/reserve_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reserveStateProvider =
    StateNotifierProvider<ReserveState, Map<String, String>>(
  (ref) => ReserveState(),
);
