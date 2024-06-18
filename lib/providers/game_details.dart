import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/services/services.dart';

final gameDetailsFutureProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, gameId) {
  return ref.watch(apiServicesProvider).getGameDetails(gameId);
});
