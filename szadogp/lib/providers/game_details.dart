import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/services/services.dart';

final gameDetailsFutureProvider = FutureProvider<Map<String, dynamic>>((ref) {
  return ref.watch(apiServicesProvider).getGameDetails();
});
