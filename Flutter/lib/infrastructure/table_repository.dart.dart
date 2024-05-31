// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/tokenProvider.dart';

import 'package:http/http.dart' as http;

class TableService {
  final http.Client client;
  TableService(this.client);

  Future<Map<String, String>> table(ref, String typeH, String floor,
      String tableNUM, String seatsH, String method) async {
    try {
      dynamic response;
      const urll = 'http://10.5.223.79:5000/';
      var curr_url = 'tables';
      if (method == "create") {
        response = await client.post(Uri.parse('${urll}${curr_url}'), headers: {
          "token": ref.read(tokenProvider.notifier).state
        }, body: {
          'seats': seatsH,
          'type': typeH,
          'floor': floor,
          'tableNUM': tableNUM
        });
      } else if (method == "read") {
        response = await client.get(Uri.parse('${urll}${curr_url}/${tableNUM}'),
            headers: {"token": ref.read(tokenProvider.notifier).state});
      } else if (method == "update") {
        response = await http.patch(Uri.parse('${urll}${curr_url}/${tableNUM}'),
            headers: {
              "token": ref.read(tokenProvider.notifier).state
            },
            body: {
              'updseats': seatsH,
              'updtype': floor,
              'updfloor': typeH,
              'tableNum': tableNUM
            });
      } else if (method == "delete") {
        print('${urll}${curr_url}}/${tableNUM}');
        response = await client.delete(
            Uri.parse('${urll}${curr_url}/${tableNUM}'),
            headers: {"token": ref.read(tokenProvider.notifier).state});
      }
      print('This is the status code ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print(responseData["status"]);

        if (responseData["status"] == "success") {
          if (method != "read") {
            print("aaaaaaa");
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
          final errorMessage = responseData['message'];
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
