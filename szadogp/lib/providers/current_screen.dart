import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/screens/login.dart';

final currentScreenProvider = StateProvider<Widget>((ref) {
  final String localToken = Hive.box('user-token').get(1) ?? '';
  if (localToken != '') {
    return const HomeScreen();
  }

  return const LoginScreen();
});
