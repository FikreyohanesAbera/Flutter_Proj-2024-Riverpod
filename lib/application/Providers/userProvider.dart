import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:flutter_application_1/application/Providers/userStateProvider.dart';
import 'package:flutter_application_1/application/states/user_state.dart';
import 'package:flutter_application_1/application/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = FutureProvider.autoDispose<String>(
  (ref) => ref
      .watch(userStateProvider.notifier)
      .user(ref.read(tokenProvider.notifier).state),
);
