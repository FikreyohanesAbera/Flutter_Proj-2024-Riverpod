import 'package:flutter_application_1/application/states/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginStateProvider = StateNotifierProvider((ref) => LoginState());
