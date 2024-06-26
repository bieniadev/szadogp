import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
      throw Exception(response.reasonPhrase);
    }
  }

  //userinfo
  Future<Map<String, dynamic>> getUserInfo() async {
    final token = await Hive.box('user-token').get(1);
    final uri = Uri.parse('$baseUrl/api/user-profile/profile');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
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
    Map<String, dynamic> request = {'userId': userId};
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

    final uri = Uri.parse('$baseUrl/api/game-manager/$runningGameId/start-game');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'}; //kys Content-Type
    Response response = await put(uri, headers: requestHeaders, body: encodedBody);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //finish game in database
  Future<Map<String, dynamic>> finishGame(String runningGameId) async {
    final token = await Hive.box('user-token').get(1);

    final uri = Uri.parse('$baseUrl/api/game-manager/$runningGameId/finish-game');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await put(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //close game in database
  Future<Map<String, dynamic>> closeGame(List<dynamic> ranking, String note, String runningGameId) async {
    final token = await Hive.box('user-token').get(1);
    final Map<String, dynamic> request = {
      'ranking': ranking,
      'note': note,
    };
    String encodedBody = json.encode(request);
    final uri = Uri.parse('$baseUrl/api/game-manager/$runningGameId/close-game');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'}; //kys Content-Type
    Response response = await put(uri, headers: requestHeaders, body: encodedBody);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //upload image to database
  Future<void> uploadImageForGame(String gameId, String path) async {
    final token = await Hive.box('user-token').get(1);
    final uri = Uri.parse('$baseUrl/api/game-manager/$gameId/upload-image');
    var request = MultipartRequest('PUT', uri);
    request.files.add(await MultipartFile.fromPath(
      'file',
      path,
    ));
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token', 'Content-Type': 'multipart/form-data'}; //kys Content-Type
    request.headers.addAll(requestHeaders);
    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //chceck for other players if game started and move then to runningGame screen
  Future<Map<String, dynamic>> checkIfGameStarted(String runningGameId) async {
    final token = await Hive.box('user-token').get(1);

    final uri = Uri.parse('$baseUrl/api/game-manager/$runningGameId/check-game-started');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //chceck for other players if game ended and move then to summary screen
  Future<Map<String, dynamic>> checkIfGameEnded(String runningGameId) async {
    final token = await Hive.box('user-token').get(1);

    final uri = Uri.parse('$baseUrl/api/game-manager/$runningGameId/check-game-ended');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //get user stats recent player
  Future<dynamic> getUserStats() async {
    final token = await Hive.box('user-token').get(1);
    final uri = Uri.parse('$baseUrl/api/games/history');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //get selected game details player
  Future<Map<String, dynamic>> getGameDetails(String gameId) async {
    final token = await Hive.box('user-token').get(1);
    final uri = Uri.parse('$baseUrl/api/games/$gameId');
    final Map<String, String> requestHeaders = {'Authorization': 'Bearer $token'};
    Response response = await get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final apiServicesProvider = Provider<ApiServices>((ref) => ApiServices());

class StreamSocket {
  final _socketResponse = StreamController<Map<dynamic, dynamic>>();

  addToSink(data) => _socketResponse.sink.add(data);

  Stream<Map<dynamic, dynamic>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class WebSocketSingleton {
  static final WebSocketSingleton _singleton = WebSocketSingleton._internal();
  late io.Socket _socket;

  factory WebSocketSingleton() {
    return _singleton;
  }

  WebSocketSingleton._internal() {
    _connectAndListen();
  }

  void _connectAndListen() {
    _socket = io.io(
      'https://szadogp-production.up.railway.app/games-realtime-manager',
      io.OptionBuilder().setTransports(['websocket']).build(),
    );

    _socket.onConnect((_) {
      debugPrint('connected');
    });

    _socket.onDisconnect((_) {
      debugPrint('disconnected');
    });
  }

  io.Socket get socket => _socket;
}
