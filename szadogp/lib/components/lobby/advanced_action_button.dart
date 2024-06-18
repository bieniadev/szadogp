import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/running_game.dart';
import 'package:szadogp/screens/running_game.dart';
import 'package:szadogp/services/services.dart';

class AdvancedActionButton extends ConsumerWidget {
  const AdvancedActionButton({
    super.key,
    required this.isAdmin,
    required this.lobbyData,
    required this.fixedGroups,
  });

  final bool isAdmin;
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

                Map<String, dynamic> eventBody = {
                  'roomId': lobbyData['roomId'],
                };
                WebSocketSingleton().socket.emit('start-game', eventBody);

                Hive.box('user-token').put(3, response);
                ref.read(currentScreenProvider.notifier).state = const RunningGameScreen();
                ref.read(isLoadingProvider.notifier).state = false;
              } catch (err) {
                ref.read(isLoadingProvider.notifier).state = false;
                throw Exception(err);
              }
            },
            hintText: 'START',
            hasBorder: false,
          )
        : const SizedBox(height: 0);
  }
}
