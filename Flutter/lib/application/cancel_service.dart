// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/isChanged.dart';
import 'package:flutter_application_1/application/Providers/myres.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_application_1/application/Providers/userProvider.dart';
import 'package:http/http.dart' as http;

class CancelService {
  static Future<Map<String, String>> cancel(
      ref, String time, int tablesNum) async {
    try {
      const urll = 'http://192.168.1.110:5000/';
      var curr_url = 'reserve/delete';
      print(time);
      print(tablesNum);
      print('${urll}${curr_url}/${tablesNum}&${time}');

      final response = await http.delete(
        Uri.parse('${urll}${curr_url}${tablesNum}&${time}'),
      );
      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print(responseData);

        if (responseData["status"] == "success") {
          final resp = {'success': "successfull"};
          await ref.invalidate(userResProvider);

          return resp;
        } else {
          final errorMessage = json.decode(response.body)['error'] as String;
          return {'error': errorMessage};
        }
      } else {
        print("kkkkk");
        final errorMessage = json.decode(response.body)['message'] as String;
        return {'error': errorMessage};
      }
    } catch (error, stackTrace) {
      print("stackTrace: $stackTrace");
      return {"error": 'An error occurred while processing your request.'};
    }
  }
}
