import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/summary/summary_section.dart';

class GameDetailsScreen extends StatelessWidget {
  const GameDetailsScreen({
    super.key,
    required this.gameStatsData,
    required this.userData,
  });

  final Map<String, dynamic> gameStatsData;
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    const int itemLength = 6; // for debug delet
    final String isWinnerText = gameStatsData['isWinner'] ? 'Zwycięstwo' : 'Porażka';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 32,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                height: 180,
                color: gameStatsData['isWinner'] ? const Color.fromARGB(255, 209, 180, 77) : const Color.fromARGB(255, 250, 99, 99), // to do: dynamiczny kolor zwyciezcy
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isWinnerText, style: GoogleFonts.rubik(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    Row(
                      children: [
                        Text(gameStatsData['boardGameId']['name'], style: GoogleFonts.rubik(fontSize: 15, fontWeight: FontWeight.w400)),
                        Container(width: 3, height: 16, margin: const EdgeInsets.symmetric(horizontal: 5), decoration: BoxDecoration(color: Colors.grey[500], borderRadius: BorderRadius.circular(10))),
                        Text('2 dni temu', style: GoogleFonts.rubik(fontSize: 15, fontWeight: FontWeight.w400)),
                        Container(width: 3, height: 16, margin: const EdgeInsets.symmetric(horizontal: 5), decoration: BoxDecoration(color: Colors.grey[500], borderRadius: BorderRadius.circular(10))),
                        Text(gameStatsData['time'], style: GoogleFonts.rubik(fontSize: 15, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 2, color: Colors.grey[500]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(26)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  gameStatsData['boardGameId']['imageUrl'],
                  height: 100,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.1),
              height: 80 * itemLength.toDouble() + itemLength.toDouble() * 2 - 2,
              child: ListView.separated(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemLength,
                separatorBuilder: (context, index) => Container(width: double.infinity, height: 2, color: Colors.grey[500]),
                itemBuilder: (context, index) {
                  late String standing;
                  late Color boxColor;
                  switch (index) {
                    case 0:
                      standing = 'st';
                      break;
                    case 1:
                      standing = 'rd';
                      break;
                    case 2:
                      standing = 'rd';
                      break;
                    default:
                      standing = 'th';
                  }

                  switch (index) {
                    case 0:
                      boxColor = const Color.fromARGB(255, 209, 180, 77);
                      break;
                    case 1:
                      boxColor = const Color.fromARGB(255, 181, 181, 181);
                      break;
                    case 2:
                      boxColor = const Color.fromARGB(255, 178, 101, 29);
                      break;
                    default:
                      boxColor = const Color.fromARGB(255, 32, 27, 41);
                  }

                  return Row(
                    children: [
                      Container(
                        height: 80,
                        width: 50,
                        alignment: Alignment.center,
                        color: boxColor,
                        child: Text('${index + 1}$standing', style: GoogleFonts.rubikMonoOne(fontSize: 14)),
                      ),
                      const SizedBox(width: 12),
                      const CircleAvatar(radius: 25),
                      const SizedBox(width: 6),
                      Text('Nickname', style: GoogleFonts.rubik(fontSize: 15)),
                      // to do: display liste osob w grupie
                      // SizedBox(
                      //   height: gameStatsData['winnersGroup'].length == 1 ? 24 + 6 : 24 * gameStatsData['winnersGroup'].length.toDouble() + 6,
                      //   width: 20,
                      //   child: ListView.separated(
                      //     padding: const EdgeInsets.all(0),
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemCount: gameStatsData['winnersGroup'].length,
                      //     separatorBuilder: (context, index) => const SizedBox(height: 6),
                      //     itemBuilder: (context, index) => Row(
                      //       children: [
                      //         gameStatsData['winnersGroup'].length == 1 ? const CircleAvatar(radius: 15) : const CircleAvatar(radius: 12), // to do: avatar
                      //         const SizedBox(width: 6),
                      //         Text(
                      //           gameStatsData['winnersGroup'][index],
                      //           style: gameStatsData['winnersGroup'].length == 1 ? const TextStyle(fontSize: 15) : const TextStyle(fontSize: 13),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const Spacer(),
                      Image.asset('assets/grupa_${index + 1}.png'),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 22),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, right: 16, left: 16),
              child: SummarySection(
                text: 'Notatka',
                widget: Text('sample text notatki'), //to do: read notatka from api
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, right: 16, left: 16),
              child: SummarySection(
                text: 'Zdjęcie',
                widget: Icon(
                  Icons.photo_camera_outlined,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
