import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserRecentlyGames extends StatelessWidget {
  const UserRecentlyGames({super.key, required this.userStatsData});

  final List<dynamic> userStatsData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: userStatsData.length,
      itemBuilder: (context, index) {
        int playersPerGame = userStatsData[index]['groups'].length;

        return Container(
          color: Colors.black.withOpacity(0.15),
          child: Row(
            children: [
              userStatsData[index]['isWinner'] // check for place
                  ? Container(
                      height: 100,
                      width: 50,
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
                      width: 70,
                      color: Colors.red[400],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('L', style: TextStyle(fontSize: 30)),
                          const Divider(
                            color: Colors.white,
                            thickness: 2,
                            endIndent: 25,
                            indent: 25,
                          ),
                          Text(userStatsData[index]['time'], style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
              const SizedBox(width: 10),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Image.network(userStatsData[index]['boardGameId']['imageUrl'], height: 80),
              ),
              //   const SizedBox(width: 10),
              //   Expanded(
              //     flex: 1,
              //     child: SizedBox(
              //       height: 100,
              //       child: ListView.builder(
              //         padding: const EdgeInsets.all(0),
              //         itemCount: playersPerGame,
              //         itemBuilder: (context, indx) {
              //           List<dynamic> playersPerTeam = userStatsData[index]['groups'][indx]['users'];

              //           return Row(
              //             children: [
              //               Text('TEAM: ${indx + 1}'),
              //               Container(
              //                 height: 60, // to do: fix dynamycznie wysietlana wielkosc
              //                 width: 50,
              //                 color: Colors.yellow,
              //                 child: ListView.builder(
              //                   itemCount: playersPerTeam.length,
              //                   itemBuilder: (context, idx) {
              //                     playersPerTeam[idx];
              //                     print('CO JA PRINTUJE: ${playersPerTeam[idx]}');

              //                     return Text(playersPerTeam[idx]['username']);
              //                   },
              //                 ),
              //               )
              //             ],
              //           );
              //         },
              //       ),
              //     ),
              //   ),

              //   Text('Kto gral: ${userStatsData[index]['groups']['gropusIdentifier'][0]}'), // to do better result who played with
            ],
          ),
        );
      },
    );
  }
}
