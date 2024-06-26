import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/components/user-stats/user_banner_appbar.dart';
import 'package:szadogp/components/user-stats/user_recentlygames.dart';
import 'package:szadogp/components/user-stats/user_settings_panel.dart';
import 'package:szadogp/components/user-stats/user_stats.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/providers/user_stats.dart';
import 'package:szadogp/providers/user_token.dart';
import 'package:szadogp/screens/login.dart';

class UserStatsScreen extends ConsumerWidget {
  const UserStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider); // uncomment
    List<dynamic> userRecentGames = ref.read(userRecentGamesProvider);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // final data = kDebugUserData;
    // userRecentGames = kDebugStatsData;

    void logOut() {
      Hive.box('user-token').delete(1);
      Hive.box('user-token').delete(2);
      ref.read(userTokenProvider.notifier).state = '';
      ref.read(currentScreenProvider.notifier).state = const LoginScreen();
      ref.read(isLoadingProvider.notifier).state = false;
      ref.invalidate(userDataProvider);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }

    return userData.when(
        data: (data) {
          return Scaffold(
              extendBodyBehindAppBar: true,
              key: scaffoldKey,
              endDrawer: UserSettingsPanel(userInfo: data, logOut: logOut),
              //appbar z tlem
              body: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [UserBannerAppbar(scaffoldKey: scaffoldKey, username: data['username'])],
                  body: Column(
                    children: [
                      // overal stats user/podsumowanie
                      UserStats(eloPoints: data['eloPoints']),

                      // lista z recent played grami
                      Expanded(child: UserRecentlyGames(userStatsData: userRecentGames, userData: data)),
                    ],
                  )));
        },
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, s) => Scaffold(body: Center(child: Text('$err', textAlign: TextAlign.center))));
  }
}
