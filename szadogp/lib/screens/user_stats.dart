import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/components/user-stats/user_banner.dart';
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
    final userData = ref.watch(userDataProvider);
    final userInfo = ref.read(userInfoProvider);
    final userTestStats = ref.read(testUserStatsProvider);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    //to do: zmienic nasluchiwanie i ustawic request z api = lepsze rozwiazanie naprawi to dynamiczne sprawdzenie zakonczonej gry w statach

    void logOut() {
      Hive.box('user-token').delete(1);

      ref.read(userTokenProvider.notifier).state = '';
      ref.read(currentScreenProvider.notifier).state = const LoginScreen();
      ref.read(isLoadingProvider.notifier).state = false;
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }

    return userData.when(
        data: (data) {
          return Scaffold(
              extendBodyBehindAppBar: true,
              key: scaffoldKey,
              appBar: UserBannerAppbar(
                scaffoldKey: scaffoldKey,
              ),
              drawer: UserSettingsPanel(
                userInfo: userInfo,
                logOut: logOut,
              ),
              //   endDrawer: UserSettingsPanel(
              //     userInfo: userInfo,
              //     logOut: logOut,
              //   ), // to do: z jakiegos powodu nie dziala prawy?
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
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, s) {
          return Scaffold(body: Center(child: Text('$err')));
        });
  }
}
