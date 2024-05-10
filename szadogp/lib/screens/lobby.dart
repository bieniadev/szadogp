import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/screens/running_game.dart';
import 'package:szadogp/services/services.dart';
import 'package:szadogp/components/popup.dart';

class LobbyScreen extends ConsumerWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Map<String, dynamic> lobbyData = ref.watch(lobbyDataProvider);
    // Map<String,dynamic> userInfo = ref.read(userInfoProvider); //test?? czy dziala porownywanie

    // final bool isAdmin = lobbyData['creatorId']== ? true : false; // po == dac userInfo[<data>]
    const bool isAdmin = true;

    Map<String, dynamic> lobbyData = {
      'boardGameId': {
        'name': 'Catan',
        'imageUrl':
            'https://static1.colliderimages.com/wordpress/wp-content/uploads/2015/02/settlers-of-catan-slice.jpg'
      },
      'users': [
        {'id': '1', 'username': 'Ben'},
        {'id': '2', 'username': 'Rud'},
        {'id': '3', 'username': 'Kond'},
        {'id': '4', 'username': 'bardzodluginickname'},
        {'id': '5', 'username': 'Spell'},
        {'id': '6', 'username': 'Macrel'},
      ],
      'code': 'TEST12'
    };

    deleteUserFromLobby(String name, String userId) {
      if (isAdmin) {
        print('granted acces as admin');
        OnTapPopups().removeUserFromLobby(context, name, userId);
      }
    }

    // print(lobbyData);
    return Scaffold(
      appBar: LogoAppbar(
        customExitButton: IconButton(
            onPressed: () {
              ref.read(currentScreenProvider.notifier).state =
                  const HomeScreen();

              //funckja do usuwania gry z bazy danych /to do
            },
            icon: const Icon(Icons.hotel_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              lobbyData['boardGameId']['name'],
              style: GoogleFonts.rubikMonoOne(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ImageRounded(imageUrl: lobbyData['boardGameId']['imageUrl']),
            const SizedBox(height: 20),
            isAdmin
                ? ActionButton(
                    onTap: () {
                      //zrobic start gry ok?
                      print('Start gierki');
                      ref.read(currentScreenProvider.notifier).state =
                          const RunningGameScreen();
                    },
                    hintText: 'START',
                    hasBorder: false,
                  )
                : const SizedBox(height: 0),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('PLAYERS',
                    style: GoogleFonts.rubikMonoOne(
                        fontSize: 20, fontWeight: FontWeight.w800)),
                const Spacer(),
                Text('GROUP',
                    style: GoogleFonts.rubikMonoOne(
                        fontSize: 20, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: lobbyData['users'].length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onDoubleTap: () => deleteUserFromLobby(
                              lobbyData['users'][index]['username'],
                              lobbyData['users'][index]['id']),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 81, 81, 81)
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(40)),
                            child: ListTile(
                              minVerticalPadding: 5,
                              // tileColor: const Color.fromARGB(255, 81, 81, 81).withOpacity(0.3),

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              contentPadding: const EdgeInsets.all(10),
                              visualDensity: const VisualDensity(vertical: 3),
                              leading: const CircleAvatar(
                                radius: 40,
                                child: Icon(Icons.account_circle_rounded,
                                    size: 60, color: Colors.black38),
                              ),
                              title: Text(
                                lobbyData['users'][index]['username'],
                                style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              // subtitle: Text('ADMIN',
                              //     style: GoogleFonts.rubikMonoOne(
                              //         color: Colors.red[400],
                              //         letterSpacing: 3,
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.w300)),
                              trailing: const Icon(
                                  Icons.one_x_mobiledata_outlined,
                                  color: Colors.white,
                                  size: 50),
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
                      lobbyData['code'],
                      style: GoogleFonts.rubik(
                        letterSpacing: 20,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        shadows: <Shadow>[
                          const Shadow(
                              offset: Offset(-1.5, -1.5), color: Colors.black),
                          const Shadow(
                              offset: Offset(1.5, -1.5), color: Colors.black),
                          const Shadow(
                              offset: Offset(1.5, 1.5), color: Colors.black),
                          const Shadow(
                              offset: Offset(-1.5, 1.5), color: Colors.black),
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
                        const Shadow(
                            offset: Offset(-1.5, -1.5), color: Colors.black),
                        const Shadow(
                            offset: Offset(1.5, -1.5), color: Colors.black),
                        const Shadow(
                            offset: Offset(1.5, 1.5), color: Colors.black),
                        const Shadow(
                            offset: Offset(-1.5, 1.5), color: Colors.black),
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
