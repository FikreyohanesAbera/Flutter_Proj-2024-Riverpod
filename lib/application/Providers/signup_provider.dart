import 'package:flutter_application_1/application/states/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/signup_state.dart';

final SignupStateProvider = StateNotifierProvider((ref) => SignupState());
