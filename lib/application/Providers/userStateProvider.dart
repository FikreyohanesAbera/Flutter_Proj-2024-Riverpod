import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:flutter_application_1/application/states/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateProvider = StateNotifierProvider<UserState, String>(
  (ref) => UserState(ref.read(tokenProvider.notifier).state),
);
