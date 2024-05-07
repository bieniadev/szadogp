import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/models/user_model.dart';
import 'package:szadogp/services/services.dart';

final currentUserDataProvider = FutureProvider<List<UserData>>((ref) async {
  return ref.watch(userProvider).getCredentials();
});
