import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/screens/home.dart';

class LobbyScreen extends ConsumerWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bool isAdmin = lobbyData['creatorId']== ? true : false;

    Map<String, dynamic> lobbyData = ref.watch(lobbyDataProvider);
    print(lobbyData);
    return Scaffold(
      appBar: LogoAppbar(
        customExitButton: IconButton(
            onPressed: () {
              ref.read(currentScreenProvider.notifier).state = const HomeScreen();

              //funckja do usuwania gry z bazy danych to do
            },
            icon: const Icon(Icons.hotel_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(lobbyData['boardGameId']['name']),
            Image.network(lobbyData['boardGameId']['imageUrl']),
            ActionButton(
              onTap: () {
                //zrobic start gry ok?
                print('Start gierki');
              },
              hintText: 'START',
            ),
            const Row(
              children: [
                Text('PLAYERS'),
                Spacer(),
                Text('GROUP'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lobbyData['users'].length,
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  child: Text(
                    lobbyData['users'][index]['username'],
                    style: GoogleFonts.rubik(),
                  ),
                ),
              ),
            ),
            Text(lobbyData['code']),
          ],
        ),
      ),
    );
  }
}
