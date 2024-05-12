import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/providers/running_game.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/screens/running_game.dart';
import 'package:szadogp/services/services.dart';
import 'package:szadogp/components/popup.dart';

class LobbyScreen extends ConsumerStatefulWidget {
  const LobbyScreen({super.key});

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  Timer? _timer;
  String _lobbyId = '';
  List<dynamic> _usersList = [];
  Map<String, dynamic> _lobbyData = {};

  void _startPolling(lobbyId) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      lobbyId = _lobbyId;
      List<dynamic> response = await ApiServices().checkForUsersInLobby(lobbyId);
      _usersList = response;
      if (_lobbyData['users'].length != _usersList.length) {
        setState(() {
          _lobbyData['users'] = _usersList;
        });
        //popup ze dolaczyl ok? :D
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _startPolling(_lobbyId);
  }

  @override
  Widget build(BuildContext context) {
    _lobbyData = ref.watch(lobbyDataProvider);
    Map<String, dynamic> userInfo = ref.read(userInfoProvider);

    _lobbyId = _lobbyData['_id'];

    //check for admin
    final bool isAdmin = _lobbyData['creatorId'] == userInfo['_id'];

    deleteUserFromLobby(String name, String userId) {
      if (isAdmin) {
        OnTapPopups().removeUserFromLobby(context, name, userId);
      }
    }

    return Scaffold(
      appBar: LogoAppbar(
        title: Image.asset('assets/images/logo.png', height: 30),
        customExitButton: IconButton(
            onPressed: () {
              ref.read(currentScreenProvider.notifier).state = const HomeScreen();

              //funckja do usuwania gry z bazy danych /to do
            },
            icon: const Icon(Icons.hotel_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Text(
            //   _lobbyData['boardGameId']['name'],
            //   style: GoogleFonts.rubikMonoOne(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 20),
            ImageRounded(imageUrl: _lobbyData['boardGameId']['imageUrl']),
            const SizedBox(height: 10),
            isAdmin
                ? ActionButton(
                    onTap: () async {
                      int usersAmmount = 1; //fake grupa number
                      List<Map<String, dynamic>> fakeGroups = [
                        ..._usersList.map((mapEntry) {
                          final String iD = mapEntry['_id']; //id gracza
                          final int groupNr = usersAmmount; // nr grupy
                          usersAmmount++; //fake grupa increment

                          final Map<String, dynamic> userInfoMap = {
                            'users': [iD], //poprawic dla kilku id o tej samej grupie
                            'groupIdentifier': groupNr
                          };
                          return userInfoMap;
                          //   print('USERMAP: $userInfoMap');

                          // return {
                          //   "groups": [
                          //     {
                          //       "groupIdentifier": 1,
                          //       "users": ["6626ba0b4ad316d11a29d388","6626ba0b4ad316d11a29d388"]
                          //     },
                          //     {
                          //       "groupIdentifier": 2,
                          //       "users": ["6626bb62c19a39054ed1dc5d"]
                          //     }
                          //   ]
                          // }
                        })
                      ];
                      try {
                        final Map<String, dynamic> response = await ApiServices().startGame(fakeGroups, _lobbyId);
                        ref.read(runningGameProvider.notifier).state = response;
                        ref.read(currentScreenProvider.notifier).state = const RunningGameScreen();
                        _timer!.cancel();
                      } catch (err) {
                        throw Exception(err);
                      }
                    },
                    hintText: 'START',
                    hasBorder: false,
                  )
                : ActionButton(
                    onTap: () async {
                      try {
                        //bambikowy kod dla wpusczania nie admina do gry
                        final Map<String, dynamic> response = await ApiServices().checkIfGameStarted(_lobbyData['_id']);

                        if (response['redirect']!) {
                          ref.read(currentScreenProvider.notifier).state = const RunningGameScreen();
                        }
                        if (!response['redirect']!) {
                          // ignore: use_build_context_synchronously
                          return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text('Gra sie jescze nie zaczeła'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      } catch (err) {
                        throw Exception(err);
                      }
                    },
                    hintText: 'CZY START?',
                    hasBorder: false,
                  ),
            const SizedBox(height: 20),
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
                  itemCount: _lobbyData['users'].length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onDoubleTap: () => deleteUserFromLobby(_lobbyData['users'][index]['username'], _lobbyData['users'][index]['_id']),
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
                              title: Text(_lobbyData['users'][index]['username'], style: GoogleFonts.rubik(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                              subtitle: Builder(
                                builder: (context) {
                                  if (isAdmin && _lobbyData['users'][index]['username'] == userInfo['username']) {
                                    return Text('ADMIN', style: GoogleFonts.rubikMonoOne(color: Colors.red[400], letterSpacing: 3, fontSize: 12, fontWeight: FontWeight.w300));
                                  }
                                  if (!isAdmin && _lobbyData['creatorId'] == _lobbyData['users'][index]['_id']) {
                                    return Text('ADMIN', style: GoogleFonts.rubikMonoOne(color: Colors.red[400], letterSpacing: 3, fontSize: 12, fontWeight: FontWeight.w300));
                                  }
                                  return const SizedBox(height: 0);
                                },
                              ),
                              trailing: const Icon(Icons.one_x_mobiledata_outlined, color: Colors.white, size: 50),
                            ),
                          ),
                        ),
                      )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: const Color.fromARGB(255, 49, 49, 49),
                    ),
                    child: Text(
                      _lobbyData['code'],
                      style: GoogleFonts.rubik(
                        letterSpacing: 20,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        shadows: <Shadow>[
                          const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                          const Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                          const Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                          const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'CODE',
                    style: GoogleFonts.rubikMonoOne(
                      fontSize: 28,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                      shadows: <Shadow>[
                        const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                        const Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                        const Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                        const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
