import 'package:flutter_application_1/infrastructure/reserve_repository.dart.dart';
import 'package:flutter_application_1/infrastructure/user_repository.dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState extends StateNotifier<String> {
  final String token;
  UserState(this.token) : super("");

  Future<String> user(ref, String token) async {
    print("hehe");
    try {
      final String result = await UserService.user(ref, token);
      state = result;
      return result;
    } catch (error) {
      state = "";
      return "";
    }
  }
}
