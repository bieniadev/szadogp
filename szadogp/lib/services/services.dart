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
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //get games
  Future<List<dynamic>> getGamesInfo() async {
    final token = await Hive.box('user-token').get(1);
    final uri = Uri.parse('$baseUrl/api/board-games');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //create room
  Future<Map<String, dynamic>> createGame(String boardgameId) async {
    final token = await Hive.box('user-token').get(1);
    Map<String, dynamic> request = {
      'boardGameId': boardgameId,
    };
    final uri = Uri.parse('$baseUrl/api/game-manager/create-game');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await post(uri, headers: requestHeaders, body: request);
    if (response.statusCode == 201) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //join room
  Future<Map<String, dynamic>> joinGame(String code) async {
    final token = await Hive.box('user-token').get(1);
    Map<String, dynamic> request = {
      'code': code,
    };
    final uri = Uri.parse('$baseUrl/api/game-manager/join-game');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await put(uri, headers: requestHeaders, body: request);

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //delete user from room
  Future<Map<String, dynamic>> deleteUserFromLobby(String userId) async {
    final token = await Hive.box('user-token').get(1);
    Map<String, dynamic> request = {
      'userId': userId,
    };
    final uri = Uri.parse('$baseUrl/api/game-manager/???');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await post(uri, headers: requestHeaders, body: request);

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //get current players
  Future<List<dynamic>> checkForUsersInLobby(String runningGameId) async {
    final token = await Hive.box('user-token').get(1);
    final uri = Uri.parse('$baseUrl/api/game-manager/$runningGameId/players');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //start game
  Future<Map<String, dynamic>> startGame(List<Map<String, dynamic>> groups, String runningGameId) async {
    final token = await Hive.box('user-token').get(1);
    final Map<String, dynamic> request = {'groups': groups};
    String encodedBody = json.encode(request);
    print('ENCODED BODY $encodedBody');

    final uri = Uri.parse('$baseUrl/api/game-manager/$runningGameId/start-game');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await put(uri, headers: requestHeaders, body: encodedBody);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print('RESULT Z API: $result');
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final apiServicesProvider = Provider<ApiServices>((ref) => ApiServices());
