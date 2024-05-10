import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/providers/user_data.dart';

class UserStatsScreen extends ConsumerWidget {
  const UserStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userData = ref.watch(userDataProvider);

    // return Scaffold(
    //   appBar: AppBar(),
    //   body: userData.when(
    //       data: (userInfo) {
    //         print(userInfo);
    //         return Column(
    //           children: [Text(userInfo['username'])],
    //         );
    //       },
    //       loading: () => const Center(child: CircularProgressIndicator()),
    //       error: (err, s) {
    //         return Text('$err');
    //       }),
    // );
    return Scaffold(
      extendBodyBehindAppBar: true, //? zobaczyc true/false diff (pasek u gory?)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        elevation: 0,
        title: const Text("Title",
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      body: Column(
        children: [Text('nick')],
      ),
    );
  }
}
