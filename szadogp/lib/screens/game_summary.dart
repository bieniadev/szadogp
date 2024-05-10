import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/screens/home.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const LogoAppbar(),
      body: Column(
        children: [
          const Text('Summary Screen'),
          ActionButton(
              onTap: () {
                ref.read(currentScreenProvider.notifier).state = const HomeScreen();
                print('wracam do domu');
              },
              hintText: 'POWRÓT',
              hasBorder: false)
        ],
      ),
    );
  }
}
