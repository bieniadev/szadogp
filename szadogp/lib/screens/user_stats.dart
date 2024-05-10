import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/user_banner.dart';
import 'package:szadogp/components/user_banner_appbar.dart';
import 'package:szadogp/components/user_recentlygames.dart';
import 'package:szadogp/components/user_stats.dart';
import 'package:szadogp/providers/user_data.dart';

class UserStatsScreen extends ConsumerWidget {
  const UserStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      body: userData.when(
          data: (userInfo) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: const UserBannerAppbar(),
              body: Column(
                children: [
                  //user banner with background
                  UserBanner(username: userInfo['username']),
                  // overal stats user/podsumowanie
                  const UserStats(),
                  // lista z recent played grami
                  const UserRecentlyGames()
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, s) {
            return Text('$err');
          }),
    );
  }
}
