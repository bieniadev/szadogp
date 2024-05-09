import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final userTokenProvider = StateProvider<String>((ref) {
  final String localToken = Hive.box('user-token').get(1) ?? '';
  if (localToken != '') {
    return localToken;
  }
  return '';
});
