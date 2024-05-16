import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/user-stats/user_banner.dart';
import 'package:szadogp/components/user-stats/user_banner_appbar.dart';
import 'package:szadogp/components/user-stats/user_recentlygames.dart';
import 'package:szadogp/components/user-stats/user_settings_panel.dart';
import 'package:szadogp/components/user-stats/user_stats.dart';
import 'package:szadogp/models/k_debug_data.dart';
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
    final userData = ref.watch(userDataProvider); //uncomment
    final userTestStats = ref.read(testUserStatsProvider);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    //to do: zmienic nasluchiwanie i ustawic request z api = lepsze rozwiazanie naprawi to dynamiczne sprawdzenie zakonczonej gry w statach
    // final userInfo = kDebugUserData;

    void logOut() {
      ref.read(isLoadingProvider.notifier).state = false;
      Hive.box('user-token').delete(1);
      ref.read(userTokenProvider.notifier).state = '';
      ref.read(currentScreenProvider.notifier).state = const LoginScreen();
    }

    // return Scaffold(
    //     extendBodyBehindAppBar: true,
    //     key: scaffoldKey,
    //     drawer: UserSettingsPanel(
    //       userInfo: userInfo,
    //       logOut: logOut,
    //     ),
    //     appBar: UserBannerAppbar(scaffoldKey: scaffoldKey),
    //     body: Column(
    //       children: [
    //         //user banner with background
    //         UserBanner(username: userInfo['username']),
    //         // overal stats user/podsumowanie
    //         const UserStats(),
    //         // lista z recent played grami
    //         Expanded(child: UserRecentlyGames(userStatsData: userTestStats)),
    //       ],
    //     ));
    return Scaffold(
        body: userData.when(
            data: (userInfo) {
              return Scaffold(
                  extendBodyBehindAppBar: true,
                  key: scaffoldKey,
                  appBar: UserBannerAppbar(
                    scaffoldKey: scaffoldKey,
                  ),
                  endDrawer: UserSettingsPanel(
                    userInfo: userInfo,
                    logOut: logOut,
                  ),
                  body: Column(
                    children: [
                      //user banner with background
                      UserBanner(username: userInfo['username']),
                      // overal stats user/podsumowanie
                      const UserStats(),
                      // lista z recent played grami
                      Expanded(child: UserRecentlyGames(userStatsData: userTestStats)),
                    ],
                  ));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, s) {
              return Text('$err');
            }));
  }
}
