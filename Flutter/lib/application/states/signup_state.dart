import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';

class SignupState extends StateNotifier<Map<String, String>> {
  SignupState() : super({});

  Future<void> signup(String email, String password, String username) async {
    try {
      final Map<String, String> result =
          await AuthService.register(email, password, username);
      state = result;
    } catch (error) {
      state = {"error": error.toString()};
    }
  }
}
