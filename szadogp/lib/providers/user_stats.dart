import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/services/services.dart';

final userStatsProvider = FutureProvider<dynamic>((ref) {
  return ref.watch(apiServicesProvider).getUserStats();
});
