import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/select_rank.dart';
import 'package:szadogp/components/summary_section.dart';
import 'package:szadogp/components/timer.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/providers/summary_game.dart';
import 'package:szadogp/providers/timer_value.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/services/services.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> summaryData = ref.read(summaryGameProvider);
    Map<String, dynamic> userInfo = ref.read(userInfoProvider);
    Duration duration = ref.read(timerValueProvider);
    String formattedTimerValue = '${(duration.inHours.toString()).padLeft(2, '0')}:${(duration.inMinutes.remainder(60).toString()).padLeft(2, '0')}:${(duration.inSeconds.remainder(60).toString()).padLeft(2, '0')}';
    TextEditingController noteController = TextEditingController();

    print('KONIEC GRY INFO: $summaryData');
    // print('USERINFO: $userInfo');

    // final bool isAdmin = summaryData['creatorId'] == userInfo['_id'];

    return Scaffold(
      appBar: const LogoAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ImageRounded(imageUrl: summaryData['boardGameId']['imageUrl']),
              Column(
                children: [
                  Text('CZAS', style: GoogleFonts.rubikMonoOne(fontSize: 36, fontWeight: FontWeight.bold)),
                  Text(formattedTimerValue, style: GoogleFonts.rubikMonoOne(fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                ],
              ),
              SummarySection(
                text: 'Ranking',
                widget: SelectRanking(
                  players: summaryData['groups'],
                ),
              ),
              const SizedBox(height: 20),
              SummarySection(
                text: 'Notatka',
                widget: TextField(
                  controller: noteController,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 20),
              ActionButton(
                  onTap: () async {
                    int usersAmmount = 1;
                    List<Map<String, dynamic>> usersRanks = [
                      ...summaryData['groups'].map((mapEntry) {
                        final int groupNr = usersAmmount; // nr grupy
                        usersAmmount++; //fake grupa increment

                        final Map<String, dynamic> userInfoMap = {
                          'groupIdentifier': groupNr,
                          'place': usersAmmount, //poprawic dla kilku id o tej samej grupie
                        };
                        return userInfoMap;
                      })
                    ];

                    //zakonczenie gry i wyslanie podsumowania do bazy
                    try {
                      final result = await ApiServices().closeGame(usersRanks, summaryData['_id']);
                      print('RESULT: $result');
                    } catch (err) {
                      print(err);
                      throw Exception(err);
                    }
                    ref.read(currentScreenProvider.notifier).state = const HomeScreen();
                  },
                  hintText: 'WYJDŹ',
                  hasBorder: false)
            ],
          ),
        ),
      ),
    );
  }
}
