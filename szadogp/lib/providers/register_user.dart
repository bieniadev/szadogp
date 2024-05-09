import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/services/services.dart';

final emailInputProvider = StateProvider<String>((ref) => '');
final passInputProvider = StateProvider<String>((ref) => '');
final usernameInputProvider = StateProvider<String>((ref) => '');

final registerUserProvider = FutureProvider<String>((ref) async {
  return ref.watch(apiServicesProvider).registerCredentials(
      ref.read(emailInputProvider),
      ref.read(passInputProvider),
      ref.read(usernameInputProvider));
});
