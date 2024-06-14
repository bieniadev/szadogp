import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/components/summary/summary_section.dart';
import 'package:szadogp/providers/choosen_image.dart';
import 'package:szadogp/providers/game_details.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/user_stats.dart';
import 'package:szadogp/screens/choose_picture.dart';
import 'package:szadogp/services/services.dart';

class GameDetailsScreen extends ConsumerWidget {
  const GameDetailsScreen({super.key, required this.gameStatsData, required this.userData, required this.gameId});

  final Map<String, dynamic> gameStatsData;
  final Map<String, dynamic> userData;
  final String gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameDetailsFuture = ref.watch(gameDetailsFutureProvider(gameId));
    selectImage(String gameId) async {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChoosePictureScreen()));

      XFile? chosenImage = ref.read(choosenImageProvider);

      if (chosenImage != null) {
        await ApiServices().uploadImageForGame(gameId, chosenImage.path);
        ref.invalidate(userStatsProvider);
        final List<dynamic> response = await ApiServices().getUserStats();
        ref.read(userRecentGamesProvider.notifier).state = response;
      }

      ref.read(isLoadingProvider.notifier).state = false;
    }

    String formatDate(String isoDate) {
      DateTime parsedDate = DateTime.parse(isoDate);
      DateTime now = DateTime.now();
      Duration difference = now.difference(parsedDate);

      int daysDifference = difference.inDays;
      int hoursDifference = difference.inHours;

      late String formattedDate;
      if (daysDifference == 0) {
        if (hoursDifference == 0) {
          formattedDate = 'Przed chwilą';
        } else {
          formattedDate = '$hoursDifference godzin temu';
        }
      } else {
        formattedDate = '$daysDifference dni temu';
      }
      return formattedDate;
    }

    return gameDetailsFuture.when(
      data: (result) {
        // print(result);
        // String isoDate = result['finishedAt'];
        // DateTime parsedDate = DateTime.parse(isoDate);
        // DateTime now = DateTime.now();
        // Duration difference = now.difference(parsedDate);

        // int daysDifference = difference.inDays;
        // int hoursDifference = difference.inHours;

        // late String formattedDate;
        // if (daysDifference == 0) {
        //   if (hoursDifference == 0) {
        //     formattedDate = 'Przed chwilą';
        //   } else {
        //     formattedDate = 'Upłynęło $hoursDifference godzin';
        //   }
        // } else {
        //   formattedDate = 'Upłynęło $daysDifference dni';
        // }

        String formattedDate = formatDate(result['finishedAt']);
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
                Container(
                  height: 180,
                  color: gameStatsData['isWinner'] ? const Color.fromARGB(255, 209, 180, 77) : const Color.fromARGB(255, 250, 99, 99),
                  child: Container(
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black.withOpacity(0.55), Colors.transparent], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
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
                            Text(formattedDate, style: GoogleFonts.rubik(fontSize: 15, fontWeight: FontWeight.w400)),
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
                  height: 80 * result['ranking'].length.toDouble() + result['ranking'].length.toDouble() * 2 - 2,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: result['ranking'].length,
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
                          SizedBox(
                            height: result['ranking'][index]['users'].length == 1 ? 42 + 6 : 24 * result['ranking'].length.toDouble() + 6,
                            width: 200,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: result['ranking'][index]['users'].length,
                              separatorBuilder: (context, index) => const SizedBox(height: 6),
                              itemBuilder: (context, idx) => Row(
                                children: [
                                  result['ranking'][index]['users'].length == 1 ? const CircleAvatar(radius: 24) : const CircleAvatar(radius: 12), // to do: avatar
                                  const SizedBox(width: 8),
                                  Text(
                                    result['ranking'][index]['users'][idx],
                                    style: result['ranking'][index]['users'].length == 1 ? const TextStyle(fontSize: 15) : const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Image.asset('assets/grupa_${index + 1}.png'),
                          const SizedBox(width: 10),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 16, left: 16),
                  child: SummarySection(
                    text: 'Notatka',
                    widget: Text(result['note']),
                  ),
                ),
                result['imageUrl'] != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 16, left: 16),
                        child: SummarySection(
                          text: 'Zdjęcie',
                          widget: Image.network(result['imageUrl']),
                        ))
                    : GestureDetector(
                        onTap: () => selectImage(result['_id']),
                        child: const Padding(
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
                      ),
              ],
            ),
          ),
        );
      },
      error: (err, stackTrace) => Scaffold(appBar: LogoAppbar(title: Image.asset('assets/images/logo.png', height: 30)), body: Center(child: Text('Wystąpił błąd podczas wczytywania danych gry: $err', textAlign: TextAlign.center))),
      loading: () => Scaffold(appBar: LogoAppbar(title: Image.asset('assets/images/logo.png', height: 30)), body: const Center(child: CircularProgressIndicator())),
    );
  }
}
