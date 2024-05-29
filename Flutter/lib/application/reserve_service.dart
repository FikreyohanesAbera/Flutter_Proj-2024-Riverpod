// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/isChanged.dart';
import 'package:flutter_application_1/application/Providers/myres.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_application_1/application/Providers/userProvider.dart';
import 'package:http/http.dart' as http;

class ReserveService {
  static Future<Map<String, String>> reserve(ref, String seatsH, String date,
      String time, String typeH, String branch, String foodName) async {
    try {
      const urll = 'http://192.168.1.110:5000/';
      var curr_url = 'reserve';

      final response = await http.post(Uri.parse('${urll}${curr_url}'), body: {
        'id': ref.read(userDataProvider.notifier).state,
        'seats': seatsH,
        'type': typeH,
        'date': date,
        'time': time,
        'branch': branch,
        "food": foodName
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print(responseData["status"]);

        if (responseData["status"] == "success") {
          final resp = {'success': "successfull"};
          print(ref.read(isChangedProvider.notifier).state);

          ref.read(isChangedProvider.notifier).state =
              !(ref.read(isChangedProvider.notifier).state);
          print(ref.read(isChangedProvider.notifier).state);
          await ref.invalidate(userResProvider);

          return resp;
        } else {
          final errorMessage = json.decode(response.body)['message'] as String;
          return {'error': errorMessage};
        }
      } else {
        print("kkkkk");
        final errorMessage = json.decode(response.body)['message'] as String;
        return {'error': errorMessage};
      }
    } catch (error, stackTrace) {
      print('stackTrace: $stackTrace');
      print(error);
      return {"error": 'An error occurred while processing your request.'};
    }
  }
}
