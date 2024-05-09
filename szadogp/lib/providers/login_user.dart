import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/services/services.dart';

final emailInputProvider = StateProvider<String>((ref) => '');
final passInputProvider = StateProvider<String>((ref) => '');

final loginUserProvider = FutureProvider<String>((ref) async {
  return ref.watch(apiServicesProvider).loginCredentials(
      ref.read(emailInputProvider), ref.read(passInputProvider));
});
