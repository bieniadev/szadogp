import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/screens/login.dart';

final currentScreenProvider = StateProvider<Widget>((ref) => const LoginScreen());
