import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/running_game.dart';
import 'package:szadogp/screens/running_game.dart';
import 'package:szadogp/services/services.dart';

class AdvancedActionButton extends ConsumerWidget {
  const AdvancedActionButton({
    super.key,
    required this.isAdmin,
    required this.timer,
    required this.lobbyData,
    required this.fixedGroups,
  });

  final bool isAdmin;
  final Timer? timer;
  final Map<String, dynamic> lobbyData;
  final List<Map<String, dynamic>> fixedGroups;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isAdmin
        ? ActionButton(
            onTap: () async {
              try {
                // if all groups selected check
                if (fixedGroups.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('Wybierz wszystkim grupy!'),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }
                //groups bug check
                List<String> fixedGroupsLenghtCheck = [];
                for (var userId in fixedGroups) {
                  for (var id in userId['users']) {
                    fixedGroupsLenghtCheck.add(id);
                  }
                }
                if (fixedGroupsLenghtCheck.length > lobbyData['users'].length) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 5),
                    content: Text('GROUPS BUG!!! > Wybierz ponownie grupę (tą samą) dla przedostatniego wybieranego usera'),
                    backgroundColor: Colors.red,
                  ));
                  return;
                }

                final Map<String, dynamic> response = await ApiServices().startGame(fixedGroups, lobbyData['_id']);
                ref.read(runningGameProvider.notifier).state = response;
                ref.read(currentScreenProvider.notifier).state = const RunningGameScreen();
                timer!.cancel();
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
                //bambikowy kod dla wpusczania nieadmina do gry
                final Map<String, dynamic> response = await ApiServices().checkIfGameStarted(lobbyData['_id']);

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
          );
  }
}
