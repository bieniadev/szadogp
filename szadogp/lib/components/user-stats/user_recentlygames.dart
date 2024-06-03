import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/screens/game_details.dart';

class UserRecentlyGames extends StatelessWidget {
  const UserRecentlyGames({super.key, required this.userStatsData, required this.userData});

  final List<dynamic> userStatsData;
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return userStatsData.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text('Tu pojawi się twoja historia gier', style: GoogleFonts.rubik(fontSize: 18), textAlign: TextAlign.center),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: userStatsData.length,
            itemBuilder: (context, index) {
              List<dynamic> winnersTeam = userStatsData[index]['winnersGroup'];
              print('Rozegrane gry: ${userStatsData[index]}');
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GameDetailsScreen(
                          gameStatsData: userStatsData[index],
                          userData: userData,
                          //   gameId: userStatsData[index]['_id'], to do: poprosic api o zwrot id gry
                          gameId: '665ddca008191a010c4c1743',
                        ))),
                child: Container(
                  color: index % 2 == 0 ? Colors.black.withOpacity(0.15) : Colors.black.withOpacity(0.25),
                  child: Row(
                    children: [
                      userStatsData[index]['isWinner'] // check is winner
                          ? Container(
                              height: 80,
                              width: 55,
                              color: const Color.fromARGB(255, 99, 114, 250),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('W', style: TextStyle(fontSize: 20)),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                    endIndent: 18,
                                    indent: 18,
                                  ),
                                  Text(userStatsData[index]['time'], style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            )
                          : Container(
                              height: 80,
                              width: 55,
                              color: const Color.fromARGB(255, 250, 99, 99),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('L', style: TextStyle(fontSize: 20)),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                    endIndent: 18,
                                    indent: 18,
                                  ),
                                  Text(userStatsData[index]['time'], style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                      const SizedBox(width: 10),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: 110,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: Image.network(userStatsData[index]['boardGameId']['imageUrl'], fit: BoxFit.cover, height: 70),
                      ),
                      const SizedBox(width: 8),
                      Image.asset('assets/puchar.png', height: 35, width: 35),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: winnersTeam.length == 1 ? 24 + 6 : 24 * winnersTeam.length.toDouble() + 6,
                          width: 20,
                          child: ListView.separated(
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: winnersTeam.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 6),
                            itemBuilder: (context, index) => Row(
                              children: [
                                winnersTeam.length == 1 ? const CircleAvatar(radius: 15) : const CircleAvatar(radius: 12), // to do: avatar
                                const SizedBox(width: 6),
                                Text(
                                  winnersTeam[index],
                                  style: winnersTeam.length == 1 ? const TextStyle(fontSize: 15) : const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
