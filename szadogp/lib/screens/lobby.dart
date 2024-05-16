import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/lobby/advanced_action_button.dart';
import 'package:szadogp/components/lobby/code_displayer.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/home.dart';
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
  final List<Map<String, dynamic>> _groups = [{}]; //puste/null dla jednego gracza, dla kazdego kolejnego dodaje sie kolejna pusta wartosc
  List<String> _usersIdGroups = [];
  final List<dynamic> _usersInLobby = [];
  List<Map<String, dynamic>> _fixedGroups = [];

  final List<int?> _groupValue = [null]; //puste/null dla jednego gracza, dla kazdego kolejnego dodaje sie kolejna pusta wartosc

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
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('${_lobbyData['users'].last['username']} dołączył do lobby'),
            backgroundColor: Colors.blue[300],
          ));
        });
      }
    });
  }

  void _dropDownHandler(value, index) {
    {
      setState(() {
        _groupValue[index] = value!;
      });
      String userGroupId = _lobbyData['users'][index]['_id'];
      Map<String, dynamic> infoUser = {'id': index + 1, 'nrGroup': _groupValue[index]!, '_id': userGroupId};
      _usersInLobby.add(infoUser);
      Map<String, dynamic> userToRemove = {};
      for (var user in _usersInLobby) {
        if (user['id'] == infoUser['id']) {
          userToRemove = user;
          break;
        }
      }
      if (_usersInLobby.length > _lobbyData['users'].length) {
        _usersInLobby.remove(userToRemove);
      }

      _usersIdGroups = [];
      for (var user in _usersInLobby) {
        if (infoUser['nrGroup'] == user['nrGroup']) {
          _usersIdGroups.add(user['_id']);
        }
      }
      _groups[index] = {
        'groupIdentifier': _groupValue[index],
        'users': _usersIdGroups,
      };
      if (_groups.last.isEmpty) {
        return;
      }
      // scale together multi groupIdentifier into one
      List<Map<String, dynamic>> removeDuplicateGroups(List<Map<String, dynamic>> groups) {
        Map<int, Map<String, dynamic>> uniqueGroupsMap = {};

        for (var group in groups) {
          int groupIdentifier = group['groupIdentifier'] ?? 0;

          if (!uniqueGroupsMap.containsKey(groupIdentifier) || (group['users'] as List<dynamic>).length > (uniqueGroupsMap[groupIdentifier]!['users'] as List<dynamic>).length) {
            uniqueGroupsMap[groupIdentifier] = group;
          }
        }

        List<Map<String, dynamic>> uniqueGroups = uniqueGroupsMap.values.toList();
        uniqueGroups.sort((a, b) => a['groupIdentifier'].compareTo(b['groupIdentifier']));
        return uniqueGroups;
      }

      //group bug lenght bug fix
      _fixedGroups = removeDuplicateGroups(_groups);
      List<String> fixedGroupsLenghtCheck = [];
      for (var userId in _fixedGroups) {
        for (var id in userId['users']) {
          fixedGroupsLenghtCheck.add(id);
        }
      }
      for (var group in _fixedGroups) {
        if (group['groupIdentifier'] != infoUser['nrGroup']) {
          for (var user in group['users']) {
            if (user == infoUser['_id'] && fixedGroupsLenghtCheck.length > _lobbyData['users'].length) {
              group['users'].remove(infoUser['_id']);
            }
          }
        }
      }
    }
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
        padding: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 4),
        child: Column(
          children: [
            ImageRounded(imageUrl: _lobbyData['boardGameId']['imageUrl']),
            const SizedBox(height: 10),
            AdvancedActionButton(
              isAdmin: isAdmin,
              timer: _timer,
              lobbyData: _lobbyData,
              fixedGroups: _fixedGroups,
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
                                          _lobbyData['users'].length,
                                          (index) => DropdownMenuItem<int>(
                                                value: index + 1,
                                                child: Text('${index + 1}', style: GoogleFonts.rubikMonoOne(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white70)),
                                              )),
                                      onChanged: (value) => _dropDownHandler(value, index),
                                    )
                                  : const SizedBox(height: 0), // to do: dynamiczne wyswietlanie stanu grupy dla nie adminow
                            ),
                          ),
                        ),
                      )),
            ),
            CodeDisplayer(lobbyData: _lobbyData),
          ],
        ),
      ),
    );
  }
}
