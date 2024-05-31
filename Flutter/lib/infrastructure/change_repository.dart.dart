// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/reserveProvider.dart';
import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:http/http.dart' as http;

class ChangeUsernameService {
  static Future<String> changeUsername(ref, String username) async {
    try {
      print('okay');
      print(ref.read(userDataProvider.notifier).state);
      const urll = 'http://10.5.223.79:5000/auth/';
      const curr_url = "changeusername";
      final response = await http.post(
        Uri.parse('${urll}${curr_url}'),
        headers: {"token": ref.read(tokenProvider.notifier).state},
        body: {
          'username': username,
          "id": ref.read(userDataProvider.notifier).state[2]
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        ref.read(userDataProvider.notifier).state[0] = username;
        return responseData['message'];
      } else {
        final errorMessage = json.decode(response.body)['message'] as String;
        return errorMessage;
      }
    } catch (error) {
      print('Error occurred: $error');
      return error.toString();
    }
  }
}
