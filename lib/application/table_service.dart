// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/isChanged.dart';
import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_application_1/application/Providers/userProvider.dart';
import 'package:http/http.dart' as http;

class TableService {
  static Future<Map<String, String>> table(ref, String typeH, String floor,
      String tableNUM, String seatsH, String method) async {
    try {
      dynamic response;
      const urll = 'http://192.168.1.110:5000/';
      var curr_url = 'tables';
      print(ref.read(tokenProvider.notifier).state);
      if (method == "create") {
        final response = await http.post(Uri.parse('${urll}${curr_url}'),
            body: {
              'seats': seatsH,
              'type': typeH,
              'floor': floor,
              'tableNUM': tableNUM
            });
      } else if (method == "read") {
        print('${urll}${curr_url}/${tableNUM}');
        response = await http.get(Uri.parse('${urll}${curr_url}/${tableNUM}'),
            headers: {
              "Authorizatation": ref.read(tokenProvider.notifier).state
            });
      } else if (method == "update") {
        response = await http.patch(Uri.parse('${urll}${curr_url}/${tableNUM}'),
            body: {
              'updseats': seatsH,
              'updtype': typeH,
              'updfloor': floor,
              'tableNum': tableNUM
            });
      } else if (method == "delete") {
        response =
            await http.delete(Uri.parse('${urll}${curr_url}}/${tableNUM}'));
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print(responseData["status"]);

        if (responseData["status"] == "success") {
          if (method != "read") {
            final resp = {'success': "successfull"};

            return resp;
          } else {
            return {
              "tableNumber": '${responseData['tableNumber']}',
              "floor": '${responseData['floor']}',
              "Type": '${responseData['type']}',
              "seats": '${responseData['seats']}'
            };
          }
        } else {
          final errorMessage = json.decode(response.body)['message'] as String;
          return {'error': errorMessage};
        }
      } else {
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
