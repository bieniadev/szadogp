import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/summary/select_rank.dart';
import 'package:szadogp/components/summary/summary_section.dart';
import 'package:szadogp/models/models_summary_screen.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/ranking.dart';
import 'package:szadogp/providers/summary_game.dart';
import 'package:szadogp/providers/timer_value.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/services/services.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> summaryData = ref.read(summaryGameProvider);
    TextEditingController noteController = TextEditingController();
    //to do: poprosic o czas gry obliczony z bazy danych
    Duration duration = ref.read(timerValueProvider); //uncomment
    String formattedTimerValue = '${(duration.inHours.toString())}:${(duration.inMinutes.remainder(60).toString()).padLeft(2, '0')}:${(duration.inSeconds.remainder(60).toString()).padLeft(2, '0')}'; //uncomment

    bool isUnique(List<int> list) {
      var set = <int>{};
      for (var num in list) {
        if (set.contains(num)) {
          return false;
        } else {
          set.add(num);
        }
      }
      return true;
    }

    SummaryData sampleData = SummaryData(
      id: summaryData['_id'],
      boardGameId: {'_id': summaryData['boardGameId']['_id'], 'name': summaryData['boardGameId']['name'], 'imageUrl': summaryData['boardGameId']['imageUrl'], 'maxPlayers': summaryData['boardGameId']['maxPlayers']},
      creatorId: '663d2d6bb91965ae304f4394',
      users: (summaryData['users'] as List<dynamic>).map((userInfo) => UserInfo(id: userInfo['_id'], username: userInfo['username'])).toList(),
      groups: [
        for (var groupData in summaryData['groups'])
          TeamGroups(
            groupIdentifier: groupData['groupIdentifier'],
            users: [
              for (var userData in groupData['users'])
                UserInfo(
                  id: userData['_id'],
                  username: userData['username'],
                ),
            ],
          ),
      ],
    );

    return Scaffold(
      appBar: LogoAppbar(title: Image.asset('assets/images/logo.png', height: 30)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ImageRounded(imageUrl: sampleData.boardGameId['imageUrl']),
              Column(
                children: [
                  Text('CZAS', style: GoogleFonts.rubikMonoOne(fontSize: 36, fontWeight: FontWeight.bold)),
                  Text(formattedTimerValue, style: GoogleFonts.rubikMonoOne(fontSize: 36, fontWeight: FontWeight.bold)),
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
                  decoration: const InputDecoration(border: OutlineInputBorder()),
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
                    ref.read(isLoadingProvider.notifier).state = false;
                    return;
                  }

                  List<int> rankNumbers = rankingList.map((e) => e.place).toList();

                  //check if same rankings occurs
                  if (!isUnique(rankNumbers)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text('Ten sam ranking występuje w kilku drużynach!'),
                      backgroundColor: Colors.red,
                    ));
                    ref.read(isLoadingProvider.notifier).state = false;
                    return;
                  }

                  if (noteController.text.isEmpty || noteController.text == '') {
                    noteController.text = 'Brak notatki...';
                    dataToCheck.note = noteController.text;
                  }

                  final SummaryRankingToSend dataToSend = dataToCheck;
                  final List<Ranking> rankingToFix = dataToSend.ranking;
                  final List<dynamic> rankingToSend = [];
                  for (var rank in rankingToFix) {
                    Map<String, int> decodedRank = {'groupIdentifier': rank.groupIdentifier, 'place': rank.place};
                    rankingToSend.add(decodedRank);
                  }
                  try {
                    await ApiServices().closeGame(rankingToSend, dataToSend.note, sampleData.id);
                    ref.read(isLoadingProvider.notifier).state = false;
                  } catch (err) {
                    ref.read(isLoadingProvider.notifier).state = false;
                    throw Exception(err);
                  }
                  ref.read(currentScreenProvider.notifier).state = const HomeScreen();
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
