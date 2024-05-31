import 'package:flutter_application_1/application/changeUsernameService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeUsernameState extends StateNotifier<String> {
  ChangeUsernameState() : super("");

  Future<void> changeUsername(ref, String username) async {
    print("yess");
    try {
      final String result =
          await ChangeUsernameService.changeUsername(ref, username);
      state = result;
    } catch (error) {
      state = error.toString();
    }
  }
}
