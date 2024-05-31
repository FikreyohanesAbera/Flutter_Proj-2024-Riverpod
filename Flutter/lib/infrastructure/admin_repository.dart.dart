// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:http/http.dart' as http;

class AdminService {
  static Future<Map<String, String>> admin(
      ref, String email, String password, String role) async {
    try {
      const urll = 'http://10.5.223.79:5000/auth/';
      var curr_url = (role != 'Admin') ? 'login' : "admin";

      final response = await http.post(
        Uri.parse('${urll}${curr_url}'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print(responseData);
        final String token = responseData['token'];
        ref.read(tokenProvider.notifier).state = token;
        final resp = {'success': "successfull"};
        return resp;
      } else {
        final errorMessage = json.decode(response.body)['message'] as String;
        return {'error': errorMessage};
      }
    } catch (error, st) {
      print('Error occurred: $error');
      print("stacktrace $st");
      return {"error": 'An error occurred while processing your request.'};
    }
  }

  static Future<Map<String, String>> register(
      String email, String password, String username) async {
    try {
      const urll = 'http://10.5.223.79:5000/auth/';
      var curr_url = 'signup';
      final response = await http.post(
        Uri.parse('${urll}${curr_url}'),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        final resp = {'success': "successfull"};
        return resp;
      } else {
        final errorMessage = json.decode(response.body)['message'] as String;
        return {'error': errorMessage};
      }
    } catch (error) {
      print('Error occurred: $error');
      return {"error": 'An error occurred while processing your request.'};
    }
  }
}
