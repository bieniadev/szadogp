import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/providers/login_user.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(loginUserProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Home', selectionColor: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              const Text('SIEMANOO'),
              userProvider.when(
                data: (userResponse) {
                  String userToken = userResponse;
                  return Text('Twój poufny token: $userToken');
                },
                error: (err, s) => Text(
                  err.toString(),
                ),
                loading: (() => const CircularProgressIndicator()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
