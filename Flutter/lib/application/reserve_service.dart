// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/isChanged.dart';
import 'package:flutter_application_1/application/Providers/myres.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_application_1/application/Providers/userProvider.dart';
import 'package:http/http.dart' as http;

class ReserveService {
  static Future<Map<String, String>> reserve(
      ref,
      String seatsH,
      String date,
      String time,
      String typeH,
      String branch,
      String foodName,
      bool create,
      String tableNumber,
      String checkTime) async {
    try {
      // print('table Number is ${tableNumber}');
      print('ghgh ${ref.read(userDataProvider.notifier).state}');
      const urll = 'http://192.168.1.110:5000/';
      var curr_url = 'reserve';

      dynamic response;

      if (create) {
        response = await http.post(Uri.parse('${urll}${curr_url}'), body: {
          'id': ref.read(userDataProvider.notifier).state[2],
          'seats': seatsH,
          'type': typeH,
          'date': date,
          'time': time,
          'branch': branch,
          "food": foodName,
        });
      } else {
        print('checktime is $foodName');
        response = await http.patch(Uri.parse('${urll}${curr_url}'), body: {
          'id': ref.read(userDataProvider.notifier).state[2],
          "tableNumber": tableNumber,
          'checktime': checkTime,
          'seats': seatsH,
          'type': typeH,
          'date': date,
          'time': time,
          'branch': branch,
          "food": foodName,
        });
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        if (!(responseData.containsKey("error"))) {
          final resp = {'success': "successfull"};

          await ref.invalidate(userResProvider);

          return resp;
        } else {
          final errorMessage = json.decode(response.body)['error'] as String;
          return {'error': errorMessage};
        }
      } else {
        print("kkkkk");
        final errorMessage = json.decode(response.body)['error'] as String;
        return {'error': errorMessage};
      }
    } catch (error, stackTrace) {
      print('stackTrace: $stackTrace');
      print(error);
      return {"error": 'An error occurred while processing your request.'};
    }
  }
}
