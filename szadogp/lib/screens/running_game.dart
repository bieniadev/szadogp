import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/timer.dart';
import 'package:szadogp/providers/timer_value.dart';

class RunningGameScreen extends StatelessWidget {
  const RunningGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> lobbyData = ref.watch(lobbyDataProvider);
    // Map<String,dynamic> userInfo = ref.read(userInfoProvider); //test?? czy dziala porownywanie

    // final bool isAdmin = lobbyData['creatorId']== ? true : false; // po == dac userInfo[<data>]
    const bool isAdmin = true;

    Duration timerValue = const Duration();

    finishGame(val) {
      timerValue = val;
      //zrobic koniec gry ok?
      print('koniec gierki');
      print('TimerVALUE: ${timerValue.inSeconds}');
    }

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

    return Scaffold(
      appBar: const LogoAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Text(lobbyData['boardGameId']['name'],
                style: GoogleFonts.rubikMonoOne(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            ImageRounded(imageUrl: lobbyData['boardGameId']['imageUrl']),
            const SizedBox(height: 20),
            StopwatchTimer(
              isAdmin: isAdmin,
              finishGame: finishGame,
              totalTime: timerValue,
            ), //timer

            const SizedBox(height: 30),
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
                      trailing: const Icon(Icons.one_x_mobiledata_outlined,
                          color: Colors.white, size: 50),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
