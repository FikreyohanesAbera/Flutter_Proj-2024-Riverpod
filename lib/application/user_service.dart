// lib/application/services/auth_service.dart

import 'dart:convert';
import 'package:flutter_application_1/application/Providers/tokenProvider.dart';
import 'package:flutter_application_1/application/Providers/userDataProvider.dart';
import 'package:flutter_application_1/application/Providers/userProvider.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<String> user(String token) async {
    print("pppppppppppppppppppppppppppppppp");
    try {
      const urll = 'http://192.168.1.110:5000/auth/';
      var curr_url = 'user';
      final response = await http.get(Uri.parse('${urll}${curr_url}'),
          headers: {'Authorization': token});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == "success") {
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
