import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerValueProvider = StateProvider<Duration>((_) => const Duration(seconds: 0));
