import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/services/services.dart';

final userDataProvider = FutureProvider<Map<String, dynamic>>((ref) {
  return ref.watch(apiServicesProvider).getUserInfo();
});

final userInfoProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {};
});
