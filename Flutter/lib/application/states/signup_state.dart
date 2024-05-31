import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../../infrastructure/auth_repository.dart';

class SignupState extends StateNotifier<Map<String, String>> {
  SignupState() : super({});

  Future<void> signup(String email, String password, String username) async {
    try {
      final Map<String, String> result =
          await AuthService(Client()).register(email, password, username);
      state = result;
    } catch (error) {
      state = {"error": error.toString()};
    }
  }
}
