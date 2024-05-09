import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/providers/user_data.dart';

class UserStatsScreen extends ConsumerWidget {
  const UserStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(),
      body: userData.when(
          data: (userInfo) {
            print(userInfo);
            return Column(
              children: [Text(userInfo['username'])],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, s) {
            return Text('$err');
          }),
    );
  }
}
