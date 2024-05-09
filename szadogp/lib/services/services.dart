import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
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
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //register
  Future<bool> registerCredentials(String email, String pass, String username) async {
    Map<String, dynamic> request = {
      'email': email,
      'password': pass,
      'username': username,
    };
    final uri = Uri.parse('$baseUrl/api/auth/register');
    final response = await post(uri, body: request);
    if (response.statusCode == 201) {
      return true;
    } else {
      //   print('RESPONSE: ${response.body}');
      throw Exception(response.reasonPhrase);
    }
  }

  //userinfo
  Future<Map<String, dynamic>> getUserInfo() async {
    final token = await Hive.box('user-token').get(1);
    final uri = Uri.parse('$baseUrl/api/auth/me');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      //   print(response.body);
      final Map<String, dynamic> result = jsonDecode(response.body);
      print(result);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //get games
  Future<Map<String, dynamic>> getGamesInfo() async {
    final token = await Hive.box('user-token').get(1);
    final uri = Uri.parse('$baseUrl/api/board-games');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> result = jsonDecode(response.body);
      print(result);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final apiServicesProvider = Provider<ApiServices>((ref) => ApiServices());
