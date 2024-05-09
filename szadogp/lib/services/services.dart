import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class ApiServices {
  //api link
  String baseUrl = 'https://szadogp-production.up.railway.app';

  //login
  Future<String> loginCredentials(String email, String pass) async {
    Map<String, dynamic> request = {
      'email': email,
      'password': pass,
    };
    final uri = Uri.parse('$baseUrl/api/auth/login');
    final response = await post(uri, body: request);
    if (response.statusCode == 201) {
      final String result = jsonDecode(response.body)['accessToken'];

      //to do: zapisac token w pamieci lokalnej urządzenia = e mati?
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //register
  Future<String> registerCredentials(
      String email, String pass, String username) async {
    Map<String, dynamic> request = {
      'email': email,
      'password': pass,
      'username': username,
    };
    final uri = Uri.parse('$baseUrl/api/auth/register');
    final response = await post(uri, body: request);
    if (response.statusCode == 201) {
      final String result = jsonDecode(response.body)['accessToken'];
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final apiServicesProvider = Provider<ApiServices>((ref) => ApiServices());
