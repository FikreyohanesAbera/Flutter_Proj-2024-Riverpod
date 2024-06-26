// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<String> user(ref, String token) async {
    print("pppppppppppppppppppppppppppppppp");
    print("the token is  ${ref.read(tokenProvider.notifier).state}");
    try {
      const urll = 'http://10.5.223.79:5000/auth/';
      var curr_url = 'user';
      final response = await http.get(Uri.parse('${urll}${curr_url}'),
          headers: {'token': ref.read(tokenProvider.notifier).state});

      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData['status'] == "success") {
          List<String> listt = [
            responseData['name'],
            responseData['email'],
            responseData['id']
          ];
          ref.read(userDataProvider.notifier).state = listt;
          print(ref.read(userDataProvider.notifier).state);

          return responseData['id'];
        }
      } else {
        return "";
      }
    } catch (error) {
      return "";
    }
    return "";
  }
}
