import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectGameScreen extends ConsumerWidget {
  const SelectGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userData = ref.watch(loginUserProvider);

    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Lista z wyborem gier')),
    );
  }
}
