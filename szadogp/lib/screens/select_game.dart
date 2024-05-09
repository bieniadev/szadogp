import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/logo_appbar.dart';

class SelectGameScreen extends ConsumerWidget {
  const SelectGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userData = ref.watch(loginUserProvider);

    return Scaffold(
      appBar: const LogoAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) => Card(
            color: Colors.grey,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(30),
              child: Text('Gra ${index + 1}'),
            ),
          ),
        ),
      ),
    );
  }
}
