import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/screens/login.dart';
// import 'package:szadogp/screens/user_stats.dart';
// import 'package:szadogp/screens/running_game.dart';

final currentScreenProvider = StateProvider<Widget>((ref) {
  final String localToken = Hive.box('user-token').get(1) ?? '';
  if (localToken != '') {
    return const HomeScreen();
  }

  return const LoginScreen();
  // return const UserStatsScreen(); //uncomment for degug
});
