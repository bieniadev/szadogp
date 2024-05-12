import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/select_rank.dart';
import 'package:szadogp/components/summary_section.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/summary_game.dart';
import 'package:szadogp/providers/timer_value.dart';
// import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/services/services.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> summaryData = ref.read(summaryGameProvider);
    // Map<String, dynamic> userInfo = ref.read(userInfoProvider);
    Duration duration = ref.read(timerValueProvider);
    String formattedTimerValue = '${(duration.inHours.toString()).padLeft(2, '0')}:${(duration.inMinutes.remainder(60).toString()).padLeft(2, '0')}:${(duration.inSeconds.remainder(60).toString()).padLeft(2, '0')}';
    TextEditingController noteController = TextEditingController();

    // final bool isAdmin = summaryData['creatorId'] == userInfo['_id'];

    //sample summary data (2 players)
    //{_id: 664129c14b648461ac6586c6, boardGameId: {_id: 663d12b800edff98b2c91d8d, name: Terraformacja Marsa, imageUrl: https://ik.imagekit.io/szadogp/terraformacja-marsa.jpg?updatedAt=1715278480856, maxPlayers: 5}, code: OD01VT, status: CLOSING_LOBBY, creatorId: 663d2d6bb91965ae304f4394, users: [{_id: 663d2d6bb91965ae304f4394, username: sigma1337}, {_id: 663a7572cf6ea2b33f6e8804, username: Benia}], groups: [{groupIdentifier: 1, users: [{_id: 663d2d6bb91965ae304f4394, username: sigma1337}]}, {groupIdentifier: 2, users: [{_id: 663a7572cf6ea2b33f6e8804, username: Benia}]}], ranking: [], createdAt: 2024-05-12T20:42:41.933Z, updatedAt: 2024-05-12T20:45:48.578Z, __v: 0, startedAt: 2024-05-12T20:43:08.448Z, finishedAt: 2024-05-12T20:45:48.578Z}

    return Scaffold(
      appBar: LogoAppbar(title: Image.asset('assets/images/logo.png', height: 30)),
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
                widget: SelectRanking(players: summaryData['groups']),
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
                          'place': usersAmmount - 1, //poprawic dla kilku id o tej samej grupie
                        };
                        return userInfoMap;
                      })
                    ];

                    //zakonczenie gry i wyslanie podsumowania do bazy
                    try {
                      await ApiServices().closeGame(usersRanks, summaryData['_id']);
                    } catch (err) {
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
