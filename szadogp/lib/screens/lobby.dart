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
            const SizedBox(height: 20),
            Image.network(lobbyData['boardGameId']['imageUrl']),
            const SizedBox(height: 20),
            ActionButton(
              onTap: () {
                //zrobic start gry ok?
                print('Start gierki');
              },
              hintText: 'START',
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
                itemCount: lobbyData['users'].length,
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.account_circle_rounded, size: 60, color: Colors.black38),
                        ),
                        title: Text(
                          lobbyData['users'][index]['username'],
                          style: GoogleFonts.rubik(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        subtitle: const Text('isadmin?', style: TextStyle(color: Colors.red)),
                        trailing: const Icon(Icons.one_x_mobiledata_outlined, color: Colors.white, size: 50),
                      )),
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
