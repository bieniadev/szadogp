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
  List<Map<String, dynamic>> _groups = [{}];
  List<String> _usersIdGroups = [];
  List<dynamic> usersInLobby = [];
  List<Map<String, dynamic>> _fixedGroups = [];

  final List<int?> _groupValue = [null];

  //func checking for players to join
  void _startPolling(lobbyId) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      lobbyId = _lobbyId;
      List<dynamic> response = await ApiServices().checkForUsersInLobby(lobbyId);
      _usersList = response;
      if (_lobbyData['users'].length != _usersList.length) {
        setState(() {
          _lobbyData['users'] = _usersList;
          _groupValue.add(null);
          _groups.add({});
        });
        //to do: popup ze dolaczyl ok? :D
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

              // to do: funckja do usuwania gry z bazy danych
            },
            icon: const Icon(Icons.hotel_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 4),
        child: Column(
          children: [
            ImageRounded(imageUrl: _lobbyData['boardGameId']['imageUrl']),
            const SizedBox(height: 10),
            isAdmin
                ? ActionButton(
                    onTap: () async {
                      try {
                        final Map<String, dynamic> response = await ApiServices().startGame(_fixedGroups, _lobbyId);
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
            const SizedBox(height: 15),
            Row(
              children: [
                Text('PLAYERS', style: GoogleFonts.rubikMonoOne(fontSize: 20, fontWeight: FontWeight.w800)),
                const Spacer(),
                Text('GROUP', style: GoogleFonts.rubikMonoOne(fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 5),
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
                              trailing: isAdmin
                                  ? DropdownButton<int>(
                                      value: _groupValue[index],
                                      items: List.generate(
                                          5, // to do: przy dynamicznym renderowanu itemow wywala err  zmienna-> _lobbyData['users'].length
                                          (index) => DropdownMenuItem<int>(
                                                value: index + 1,
                                                child: Text('NR: ${index + 1}'),
                                              )),
                                      onChanged: (value) {
                                        setState(() {
                                          _groupValue[index] = value!;
                                        });
                                        String userGroupId = _lobbyData['users'][index]['_id'];
                                        Map<String, dynamic> infoUser = {'id': index + 1, 'nrGroup': _groupValue[index]!, '_id': userGroupId};
                                        usersInLobby.add(infoUser);
                                        Map<String, dynamic> userToRemove = {};
                                        for (var user in usersInLobby) {
                                          if (user['id'] == infoUser['id']) {
                                            userToRemove = user;
                                            break;
                                          }
                                        }
                                        if (usersInLobby.length > _lobbyData['users'].length) {
                                          usersInLobby.remove(userToRemove);
                                        }

                                        _usersIdGroups = [];
                                        for (var user in usersInLobby) {
                                          if (infoUser['nrGroup'] == user['nrGroup']) {
                                            _usersIdGroups.add(user['_id']);
                                          }
                                        }
                                        _groups[index] = {
                                          'groupIdentifier': _groupValue[index],
                                          'users': _usersIdGroups,
                                        };

                                        List<Map<String, dynamic>> removeDuplicateGroups(List<Map<String, dynamic>> groups) {
                                          Map<int, Map<String, dynamic>> uniqueGroupsMap = {};

                                          for (var group in groups) {
                                            int groupIdentifier = group['groupIdentifier'] ?? 0; // to do: przy wybieraniu peirwszy raz grupy group['groupIdentifier'] zwraca null (2 razy przy 2 graczach), zrobic odpowieni handling np kazac wybrac grupy do konca

                                            if (!uniqueGroupsMap.containsKey(groupIdentifier) || (group['users'] as List<dynamic>).length > (uniqueGroupsMap[groupIdentifier]!['users'] as List<dynamic>).length) {
                                              uniqueGroupsMap[groupIdentifier] = group;
                                            }
                                          }

                                          // Sortowanie mapy według klucza 'groupIdentifier'
                                          List<Map<String, dynamic>> uniqueGroups = uniqueGroupsMap.values.toList();
                                          uniqueGroups.sort((a, b) => a['groupIdentifier'].compareTo(b['groupIdentifier']));

                                          return uniqueGroups;
                                        }

                                        _fixedGroups = removeDuplicateGroups(_groups);
                                      },
                                    )
                                  : const SizedBox(height: 0), // to do: dynamiczne wyswietlanie stanu grupy dla nie adminow
                            ),
                          ),
                        ),
                      )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
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
