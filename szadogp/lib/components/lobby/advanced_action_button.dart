import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/options_gamebutton.dart';
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
                // if solo in lobby check
                if (lobbyData['users'].length < 2) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('Nie możesz sam wystartować!'),
                    backgroundColor: Colors.red,
                  ));
                  ref.read(isLoadingProvider.notifier).state = false;
                  return;
                }
                // if all groups selected check
                if (fixedGroups.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('Wybierz wszystkim grupy!'),
                    backgroundColor: Colors.red,
                  ));
                  ref.read(isLoadingProvider.notifier).state = false;
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
                  ref.read(isLoadingProvider.notifier).state = false;
                  return;
                }

                final Map<String, dynamic> response = await ApiServices().startGame(fixedGroups, lobbyData['_id']);
                ref.read(runningGameProvider.notifier).state = response;
                Hive.box('user-token').put(3, response);
                ref.read(currentScreenProvider.notifier).state = const RunningGameScreen();
                ref.read(optionsButtonProvider.notifier).state = [];
                ref.read(isLoadingProvider.notifier).state = false;
                timer!.cancel();
              } catch (err) {
                ref.read(isLoadingProvider.notifier).state = false;
                throw Exception(err);
              }
            },
            hintText: 'START',
            hasBorder: false,
          )
        // to do: sprawdzenie na dołączenie gracza nie ma sensu bo zwraca puste grupy (musi wysłać api request ze zwrotna informacja o grupach wybranych)
        // : ActionButton(
        //     onTap: () async {
        //       try {
        //         //bambikowy kod dla wpusczania nieadmina do gry
        //         final Map<String, dynamic> response = await ApiServices().checkIfGameStarted(lobbyData['_id']);

        //         if (response['redirect']!) {
        //           ref.read(currentScreenProvider.notifier).state = const RunningGameScreen();
        //         }
        //         if (!response['redirect']!) {
        //           ref.read(isLoadingProvider.notifier).state = false;
        //           // ignore: use_build_context_synchronously
        //           return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //             duration: Duration(seconds: 3),
        //             content: Text('Gra sie jescze nie zaczeła'),
        //             backgroundColor: Colors.red,
        //           ));
        //         }
        //         ref.read(isLoadingProvider.notifier).state = false;
        //       } catch (err) {
        //         ref.read(isLoadingProvider.notifier).state = false;
        //         throw Exception(err);
        //       }
        //     },
        //     hintText: 'CZY START?',
        //     hasBorder: false,
        //   );
        : const SizedBox(height: 0);
  }
}
