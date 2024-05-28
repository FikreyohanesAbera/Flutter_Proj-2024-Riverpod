import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_service.dart';

class LoginState extends StateNotifier<Map<String, String>> {
  LoginState() : super({});

  Future<void> login(ref, String email, String password, String role) async {
    print("yess");
    try {
      final Map<String, String> result =
          await AuthService.login(ref, email, password, role);
      // If login successful, navigate to home screen
      state = result;
    } catch (error) {
      // If login fails, show error message
      state = {"error": error.toString()};
    }
  }
}
