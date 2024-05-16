import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/user-stats/user_banner.dart';
import 'package:szadogp/components/user-stats/user_banner_appbar.dart';
import 'package:szadogp/components/user-stats/user_recentlygames.dart';
import 'package:szadogp/components/user-stats/user_stats.dart';
import 'package:szadogp/models/k_debug_data.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/providers/user_stats.dart';

class UserStatsScreen extends ConsumerWidget {
  const UserStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userData = ref.watch(userDataProvider); //uncomment
    final userTestStats = ref.read(testUserStatsProvider);
    //to do: zmienic nasluchiwanie i ustawic request z api = lepsze rozwiazanie naprawi to dynamiczne sprawdzenie zakonczonej gry w statach
    final userInfo = kDebugUserData;

    return Scaffold(
      body: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const UserBannerAppbar(),
          body: Column(
            children: [
              //user banner with background
              UserBanner(username: userInfo['username']),
              // overal stats user/podsumowanie
              const UserStats(),
              // lista z recent played grami
              Expanded(child: UserRecentlyGames(userStatsData: userTestStats)),
            ],
          )),
      // userData.when(
      //     data: (userInfo) {
      //       return Scaffold(
      //           extendBodyBehindAppBar: true,
      //           appBar: const UserBannerAppbar(),
      //           body: Column(
      //             children: [
      //               //user banner with background
      //               UserBanner(username: userInfo['username']),
      //               // overal stats user/podsumowanie
      //               const UserStats(),
      //               // lista z recent played grami
      //               Expanded(child: UserRecentlyGames(userStatsData: userTestStats)),
      //             ],
      //           ));
      //     },
      //     loading: () => const Center(child: CircularProgressIndicator()),
      //     error: (err, s) {
      //       return Text('$err');
      //     }),
    );
  }
}
