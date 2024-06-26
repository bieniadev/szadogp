import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/services/services.dart';

final boardgamesDataProvider = FutureProvider<List<dynamic>>((ref) {
  return ref.watch(apiServicesProvider).getGamesInfo();
});
