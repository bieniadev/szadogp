import 'package:flutter/material.dart';

class UserRecentlyGames extends StatelessWidget {
  const UserRecentlyGames({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sampleItems = [
      {'isWon': true, 'who': 'Rudy', 'timer': '1:34:53'},
      {'isWon': false, 'who': 'Bienia', 'timer': '2:14:53'},
    ];
    return Expanded(
      child: ListView.builder(
        itemCount: sampleItems.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.black.withOpacity(0.15),
            child: Row(
              children: [
                sampleItems[index]['isWon'] // check for place
                    ? Container(
                        height: 100,
                        width: 70,
                        color: Colors.blue[400],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('W', style: TextStyle(fontSize: 30)),
                            const Divider(
                              color: Colors.white,
                              thickness: 2,
                              endIndent: 25,
                              indent: 25,
                            ),
                            Text(sampleItems[index]['timer'],
                                style: const TextStyle(fontSize: 16)),
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
                            Text(sampleItems[index]['timer'],
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                const SizedBox(width: 20),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: Image.network(
                    'https://m.media-amazon.com/images/I/81jNRZ8ZunL.png', // image for game
                    height: 80,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                    'Kto gral: ${sampleItems[index]['who']}'), // to do better result who played with
              ],
            ),
          );
        },
      ),
    );
  }
}
