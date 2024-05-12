import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/logo_appbar.dart';

class GameDetailsScreen extends StatelessWidget {
  const GameDetailsScreen({super.key, required this.gameStatsData});

  final Map<String, dynamic> gameStatsData;

  @override
  Widget build(BuildContext context) {
    // print('GAME DATA: $gameStatsData');
    return Scaffold(
      appBar: LogoAppbar(
        title: Text(
          gameStatsData['boardGameId']['name'],
          style: GoogleFonts.rubikMonoOne(color: Colors.white, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('USERS: ${gameStatsData['users']}', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Text('GROUPS: ${gameStatsData['groups']}', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Text('BOARDGAMEID: ${gameStatsData['boardGameId']}', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Text('TIME: ${gameStatsData['time']}', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
