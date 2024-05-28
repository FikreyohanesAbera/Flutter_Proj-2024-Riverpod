import 'package:flutter_application_1/application/reserve_service.dart';
import 'package:flutter_application_1/application/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState extends StateNotifier<String> {
  final String token;
  UserState(this.token) : super("");

  Future<String> user(String token) async {
    print("hehe");
    try {
      final String result = await UserService.user(token);
      state = result;
      return result;
    } catch (error) {
      state = "";
      return "";
    }
  }
}
