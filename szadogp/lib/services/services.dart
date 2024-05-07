import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class ApiServices {
  //api link
  String baseUrl = 'https://szadogp-production.up.railway.app';

//   Future<List<UserData>> getCredentials() async {
//     Response response = await get(Uri.parse('https://reqres.in/api/users?page=2'));
//     if (response.statusCode == 200) {
//       //decode source code
//       final List result = jsonDecode(response.body)['data'];
//       return result.map((e) => UserData.fromJson(e)).toList();
//     } else {
//       throw Exception(response.reasonPhrase);
//     }
//   }

  Future<String> loginCredentials(String email, String pass) async {
    Map<String, dynamic> request = {
      'email': email,
      'password': pass,
    };
    final uri = Uri.parse('$baseUrl/api/auth/login');
    final response = await post(uri, body: request);
    if (response.statusCode == 201) {
      final String result = jsonDecode(response.body)['accessToken'];
      print('Token: $result');
      //to do: zapisac token w pamieci lokalnej urządzenia = e mati?
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final userProvider = Provider<ApiServices>((ref) => ApiServices());
