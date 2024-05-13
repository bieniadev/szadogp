import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/select_rank.dart';
import 'package:szadogp/components/summary_section.dart';
import 'package:szadogp/models/models_summary_screen.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/ranking.dart';
import 'package:szadogp/providers/summary_game.dart';
import 'package:szadogp/providers/timer_value.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/services/services.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final Map<String, dynamic> summaryData = ref.read(summaryGameProvider); //uncomment
    // Duration duration = ref.read(timerValueProvider); //uncomment
    // String formattedTimerValue ='${(duration.inHours.toString())}:${(duration.inMinutes.remainder(60).toString()).padLeft(2, '0')}:${(duration.inSeconds.remainder(60).toString()).padLeft(2, '0')}'; //uncomment
    TextEditingController noteController = TextEditingController();

    bool isUnique(List<int> list) {
      var set = <int>{};
      for (var num in list) {
        if (set.contains(num)) {
          return false; // Jeśli numer już istnieje, to lista nie ma unikalnych wartości
        } else {
          set.add(num); // Dodaj numer do zbioru
        }
      }
      return true; // Jeśli żaden numer nie powtórzył się, lista ma unikalne wartości
    }

    // delete after
    String formattedTimerValue = '3:23:12';
    GameSummary sampleData = GameSummary(
      id: '664129c14b648461ac6586c6',
      boardGameId: {
        '_id': '663d12b800edff98b2c91d8d',
        'name': 'Terraformacja Marsa',
        'imageUrl':
            'https://ik.imagekit.io/szadogp/terraformacja-marsa.jpg?updatedAt=1715278480856',
        'maxPlayers': 5
      },
      code: 'OD01VT',
      status: 'CLOSING_LOBBY',
      creatorId: '663d2d6bb91965ae304f4394',
      users: [
        UserInfo(id: '663a7572cf6ea2b33f6e8804', username: 'Benia'),
        UserInfo(id: '663d2d6bb91965ae304f4394', username: 'sigma1337')
      ],
      groups: [
        TeamGroups(groupIdentifier: 1, users: [
          UserInfo(id: '663d2d6bb91965ae304f4394', username: 'sigma1337'),
          UserInfo(id: '663d2d6bb91965ae304f4394', username: 'sigma1337')
        ]),
        TeamGroups(groupIdentifier: 2, users: [
          UserInfo(id: '663a7572cf6ea2b33f6e8804', username: 'Benia'),
          UserInfo(id: '54879357923574jfis9r34ji', username: 'TestowyZiom'),
        ]),
        TeamGroups(groupIdentifier: 3, users: [
          UserInfo(id: '663a7572cf6ea2b33f6e8804', username: 'Benia'),
          UserInfo(id: '54879357923574jfis9r34ji', username: 'TestowyZiom'),
        ]),
      ],
      ranking: [],
      createdAt: '2024-05-12T20:42:41.933Z',
      updatedAt: '2024-05-12T20:45:48.578Z',
      vValue: 0,
      startedAt: '2024-05-12T20:43:08.448Z',
      finishedAt: '2024-05-12T20:45:48.578Z',
    );

    return Scaffold(
      appBar:
          LogoAppbar(title: Image.asset('assets/images/logo.png', height: 30)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ImageRounded(imageUrl: sampleData.boardGameId['imageUrl']),
              Column(
                children: [
                  Text('CZAS',
                      style: GoogleFonts.rubikMonoOne(
                          fontSize: 36, fontWeight: FontWeight.bold)),
                  Text(formattedTimerValue,
                      style: GoogleFonts.rubikMonoOne(
                          fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                ],
              ),
              SummarySection(
                text: 'Ranking',
                widget: SelectRanking(players: sampleData.groups),
              ),
              const SizedBox(height: 20),
              SummarySection(
                text: 'Notatka',
                widget: TextField(
                  controller: noteController,
                  minLines: 3,
                  maxLines: 5,
                  style: GoogleFonts.rubik(fontSize: 15),
                  textCapitalization: TextCapitalization.sentences,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 20),
              ActionButton(
                onTap: () async {
                  List<Ranking> rankingList = ref.read(rankingProvider);
                  SummaryRankingToSend dataToCheck = SummaryRankingToSend(
                    ranking: rankingList,
                    note: noteController.text,
                  );

                  //check if all players selected team
                  if (rankingList.length < sampleData.groups.length) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text('Wybierz wszystkim ranking!'),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }

                  List<int> rankNumbers =
                      rankingList.map((e) => e.place).toList();

                  //check if same rankings occurs
                  if (!isUnique(rankNumbers)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      content:
                          Text('Ten sam ranking występuje w kilku drużynach!'),
                      backgroundColor: Colors.red,
                    ));
                  }

                  if (noteController.text.isEmpty ||
                      noteController.text == '') {
                    noteController.text = 'Brak notatki...';
                    dataToCheck.note = noteController.text;
                  }

                  final SummaryRankingToSend dataToSend = dataToCheck;
                  log('NOTATKA: ${dataToSend.note}');
                  try {
                    await ApiServices().closeGame(dataToCheck, sampleData.id);
                    ref.read(currentScreenProvider.notifier).state =
                        const HomeScreen();
                  } catch (err) {
                    throw Exception(err);
                  }
                },
                hintText: 'ZAPISZ',
                hasBorder: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
