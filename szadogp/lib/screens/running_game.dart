import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/timer.dart';
import 'package:szadogp/models/models_running_game.dart';
import 'package:szadogp/models/models_summary_screen.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/running_game.dart';
import 'package:szadogp/providers/timer_value.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/game_summary.dart';

class RunningGameScreen extends ConsumerWidget {
  const RunningGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> lobbyData = ref.read(runningGameProvider); // uncomment
    Map<String, dynamic> userInfo = ref.read(userInfoProvider);

    //delete after
    //sample lobby data (2 players):
    //{_id: 664129c14b648461ac6586c6, boardGameId: {_id: 663d12b800edff98b2c91d8d, name: Terraformacja Marsa, imageUrl: https://ik.imagekit.io/szadogp/terraformacja-marsa.jpg?updatedAt=1715278480856, maxPlayers: 5}, code: OD01VT, status: CREATING_LOBBY, creatorId: 663d2d6bb91965ae304f4394, users: [{_id: 663d2d6bb91965ae304f4394, username: sigma1337}, {_id: 663a7572cf6ea2b33f6e8804, username: Benia}], groups: [], ranking: [], createdAt: 2024-05-12T20:42:41.933Z, updatedAt: 2024-05-12T20:42:41.933Z, __v: 0}

    // List<Map<String, dynamic>> groups = [
    //   {
    //     'groupIdentifier': 1,
    //     'users': [
    //       {'_id': '663d2d6bb91965ae304f4394', 'username': 'sigma1337'}
    //     ]
    //   },
    //   {
    //     'groupIdentifier': 2,
    //     'users': [
    //       {'_id': '663a7572cf6ea2b33f6e8804', 'username': 'Benia'},
    //       {'_id': '663a75312412412s33f6e880', 'username': 'Testowy'}
    //     ]
    //   },
    //   {
    //     'groupIdentifier': 3,
    //     'users': [
    //       {'_id': '213572cf6ea2b33f6e81231a', 'username': 'Godsyk'},
    //     ]
    //   }
    // ];

    // Map<String, dynamic> lobbyData = {
    //   'creatorId': '663d2d6bb91965ae304f4394',
    //   'boardGameId': {'_id': '663d12b800edff98b2c91d8d', 'name': 'Terraformacja Marsa', 'imageUrl': 'https://ik.imagekit.io/szadogp/terraformacja-marsa.jpg?updatedAt=1715278480856'},
    //   '_id': 'sadad',
    //   'groups': groups,
    //   'users': [
    //     {'_id': '663d2d6bb91965ae304f4394', 'username': 'sigma1337'},
    //     {'_id': '663a7572cf6ea2b33f6e8804', 'username': 'Benia'},
    //     {'_id': '663a75312412412s33f6e880', 'username': 'Testowy'},
    //     {'_id': '213572cf6ea2b33f6e81231a', 'username': 'Godsyk'}
    //   ],
    // };

    final bool isAdmin = lobbyData['creatorId'] == userInfo['_id']; //uncomment

    Duration timerValue = const Duration();
    finishGame(val) {
      timerValue = val;
      ref.read(currentScreenProvider.notifier).state = const SummaryScreen();
      ref.read(timerValueProvider.notifier).state = timerValue; //to do: timer przeztaje liczyc przy wygaszonym ekranie/appka chodzoca w tle
    }

    //save as model
    List<TeamGroups> fixedGroups = [
      for (var groupData in lobbyData['groups'])
        TeamGroups(
          groupIdentifier: groupData['groupIdentifier'],
          users: [
            for (var userData in groupData['users'])
              UserInfo(
                id: userData['_id'],
                username: userData['username'],
              ),
          ],
        ),
    ];

    lobbyData['groups'] = fixedGroups;

    List<DecodedUser> decodedGroups = [];
    for (TeamGroups group in lobbyData['groups']) {
      for (var user in group.users) {
        DecodedUser decodedUser = DecodedUser(groupIdentifier: group.groupIdentifier, name: user.username);
        decodedGroups.add(decodedUser);
      }
    }
    return Scaffold(
      appBar: LogoAppbar(
        title: Image.asset('assets/images/logo.png', height: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            ImageRounded(imageUrl: lobbyData['boardGameId']['imageUrl']),
            const SizedBox(height: 20),
            StopwatchTimer(
              isAdmin: isAdmin,
              finishGame: finishGame,
              totalTime: timerValue,
              gameId: lobbyData['_id'],
            ), //timer

            const SizedBox(height: 30),
            Row(
              children: [
                Text('PLAYERS', style: GoogleFonts.rubikMonoOne(fontSize: 20, fontWeight: FontWeight.w800)),
                const Spacer(),
                Text('GROUP', style: GoogleFonts.rubikMonoOne(fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                  itemCount: lobbyData['users'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(color: const Color.fromARGB(255, 81, 81, 81).withOpacity(0.3), borderRadius: BorderRadius.circular(40)),
                        child: ListTile(
                          minVerticalPadding: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          contentPadding: const EdgeInsets.all(10),
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const CircleAvatar(
                            radius: 40,
                            child: Icon(Icons.account_circle_rounded, size: 60, color: Colors.black38),
                          ),
                          title: Text(lobbyData['users'][index]['username'], style: GoogleFonts.rubik(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                          subtitle: Builder(
                            builder: (context) {
                              if (isAdmin && lobbyData['users'][index]['username'] == userInfo['username']) {
                                return Text('ADMIN', style: GoogleFonts.rubikMonoOne(color: Colors.red[400], letterSpacing: 3, fontSize: 12, fontWeight: FontWeight.w300));
                              }
                              if (!isAdmin && lobbyData['creatorId'] == lobbyData['users'][index]['_id']) {
                                return Text('ADMIN', style: GoogleFonts.rubikMonoOne(color: Colors.red[400], letterSpacing: 3, fontSize: 12, fontWeight: FontWeight.w300));
                              }
                              return const SizedBox(height: 0);
                            },
                          ),
                          trailing: Text(
                            '${decodedGroups[index].groupIdentifier} ', //to do: zmienic na ikone grupy
                            style: GoogleFonts.rubikMonoOne(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white70),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
