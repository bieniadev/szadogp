import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/timer.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/providers/timer_value.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/game_summary.dart';

class RunningGameScreen extends ConsumerWidget {
  const RunningGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> lobbyData = ref.read(lobbyDataProvider);
    Map<String, dynamic> userInfo = ref.read(userInfoProvider);

    final bool isAdmin = lobbyData['creatorId'] == userInfo['_id'];

    Duration timerValue = const Duration();

    finishGame(val) {
      timerValue = val;
      ref.read(currentScreenProvider.notifier).state = const SummaryScreen();
      ref.read(timerValueProvider.notifier).state = timerValue;
    }

    return Scaffold(
      appBar: LogoAppbar(
        title: Image.asset('assets/images/logo.png', height: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            // Text(lobbyData['boardGameId']['name'], style: GoogleFonts.rubikMonoOne(fontSize: 20, fontWeight: FontWeight.bold)),
            ImageRounded(imageUrl: lobbyData['boardGameId']['imageUrl']),
            const SizedBox(height: 20),
            StopwatchTimer(
              isAdmin: isAdmin,
              finishGame: finishGame,
              totalTime: timerValue,
              gameId: lobbyData['_id'],
            ), //timer

            const SizedBox(height: 30),
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
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
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
                      title: Text(lobbyData['users'][index]['username'], style: GoogleFonts.rubik(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                      subtitle: Builder(
                        builder: (context) {
                          //   print(lobbyData['creatorId']);
                          if (isAdmin && lobbyData['users'][index]['username'] == userInfo['username']) {
                            return Text('ADMIN', style: GoogleFonts.rubikMonoOne(color: Colors.red[400], letterSpacing: 3, fontSize: 12, fontWeight: FontWeight.w300));
                          }
                          if (!isAdmin && lobbyData['creatorId'] == lobbyData['users'][index]['_id']) {
                            return Text('ADMIN', style: GoogleFonts.rubikMonoOne(color: Colors.red[400], letterSpacing: 3, fontSize: 12, fontWeight: FontWeight.w300));
                          }
                          return const SizedBox(height: 0);
                        },
                      ),
                      trailing: const Icon(Icons.one_x_mobiledata_outlined, color: Colors.white, size: 50),
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
