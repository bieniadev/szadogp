import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/user_banner.dart';
import 'package:szadogp/components/user_banner_appbar.dart';
import 'package:szadogp/components/user_recentlygames.dart';
import 'package:szadogp/components/user_stats.dart';
// import 'package:szadogp/providers/user_data.dart';

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
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: UserBannerAppbar(),
      body: Column(
        children: [
          //user banner with background
          UserBanner(),
          // overal stats user/podsumowanie
          UserStats(),
          // lista z recent played grami
          UserRecentlyGames()
        ],
      ),
    );
  }
}
