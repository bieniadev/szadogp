import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/user-stats/user_banner_appbar.dart';

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
    const int itemLength = 6; // for debug
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
                color: Colors.amber, // to do: dynamiczny kolor zwyciezcy
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Zwycięstwo', style: GoogleFonts.rubik(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    Row(
                      children: [
                        Text(gameStatsData['boardGameId']['name'], style: GoogleFonts.rubik(fontSize: 15, fontWeight: FontWeight.w400)),
                        Container(width: 3, height: 16, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(color: const Color.fromARGB(255, 99, 114, 250), borderRadius: BorderRadius.circular(10))),
                        Text('2 dni temu', style: GoogleFonts.rubik(fontSize: 15, fontWeight: FontWeight.w400)),
                        Container(width: 3, height: 16, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(color: const Color.fromARGB(255, 99, 114, 250), borderRadius: BorderRadius.circular(10))),
                        Text(gameStatsData['time'], style: GoogleFonts.rubik(fontSize: 15, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 2, color: const Color.fromARGB(255, 99, 114, 250)),
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
            SizedBox(
              height: 80 * itemLength.toDouble() + itemLength.toDouble() * 2 - 2,
              child: ListView.separated(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemLength,
                separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey.withOpacity(0.4),
                ),
                itemBuilder: (context, index) {
                  late Color boxColor;
                  late String standing;
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
                      boxColor = Colors.amber;
                      break;
                    case 1:
                      boxColor = Colors.grey;
                      break;
                    case 2:
                      boxColor = Colors.brown;
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
                      const Spacer(),
                      Image.asset('grupa_${index + 1}.png'),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              ),
            ),
            Text('Notatka here'),
          ],
        ),
      ),
    );
  }
}
