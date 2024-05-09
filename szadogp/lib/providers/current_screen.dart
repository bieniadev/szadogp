import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/screens/login.dart';
import 'package:szadogp/screens/home.dart';

// final currentScreenProvider = StateProvider<Widget>((ref) => const LoginScreen());
final currentScreenProvider =
    StateProvider<Widget>((ref) => const HomeScreen());
