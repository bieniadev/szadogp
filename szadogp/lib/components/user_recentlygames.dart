import 'package:flutter/material.dart';
import 'package:szadogp/screens/game_details.dart';

class UserRecentlyGames extends StatelessWidget {
  const UserRecentlyGames({super.key, required this.userStatsData});

  final List<dynamic> userStatsData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: userStatsData.length,
      itemBuilder: (context, index) {
        // int playersPerGame = userStatsData[index]['groups'].length;
        List<dynamic> playersTeam = userStatsData[index]['groups'];
        // print('GRUPY USEROW: $playersTeam}');
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GameDetailsScreen(gameStatsData: userStatsData[index]),
          )),
          child: Container(
            color: index % 2 == 0 ? Colors.black.withOpacity(0.15) : Colors.black.withOpacity(0.25),
            child: Row(
              children: [
                userStatsData[index]['isWinner'] // check for place
                    ? Container(
                        height: 100,
                        width: 55,
                        color: Colors.blue[400],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('W', style: TextStyle(fontSize: 24)),
                            const Divider(
                              color: Colors.white,
                              thickness: 2,
                              endIndent: 20,
                              indent: 20,
                            ),
                            Text(userStatsData[index]['time'], style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      )
                    : Container(
                        height: 100,
                        width: 55,
                        color: Colors.red[400],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('L', style: TextStyle(fontSize: 30)),
                            const Divider(
                              color: Colors.white,
                              thickness: 2,
                              endIndent: 20,
                              indent: 20,
                            ),
                            Text(userStatsData[index]['time'], style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                const SizedBox(width: 10),
                Container(
                  clipBehavior: Clip.hardEdge,
                  width: 170,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: Image.network(userStatsData[index]['boardGameId']['imageUrl'], fit: BoxFit.cover, height: 90),
                ),
                const SizedBox(width: 8),
                const Text('WIN GR:'), // wstawic tu img pucharka
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 23 * playersTeam.length.toDouble(),
                    width: 20,
                    child: ListView.builder(
                      // w tej liscie ma byc tylko pokazana zwycieska grupa
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: playersTeam.length,
                      itemBuilder: (context, index) {
                        List<dynamic> playersInTeam = playersTeam[index]['users'];
                        //   print('PLAYERSTEAM USERS LIST: ${playersTeam[index]['users']}'); //TU DAC TYLKO OSOBY Z WYGRYWAJACEJ GRUPY
                        for (var player in playersInTeam) {
                          return Text(player['username'].toString());
                        }
                        return const Text('<Empty>');
                      },
                    ),
                  ),
                ),

                //   Text('Kto gral: ${userStatsData[index]['groups']['gropusIdentifier'][0]}'), // to do better result who played with
              ],
            ),
          ),
        );
      },
    );
  }
}
