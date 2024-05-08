import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameInputProvider = StateProvider<String>((ref) => '');
final emailInputProvider = StateProvider<String>((ref) => '');
final passInputProvider = StateProvider<String>((ref) => '');
