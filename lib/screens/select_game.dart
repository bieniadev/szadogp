import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/image_border.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/providers/boardgames_data.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/lobby.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/lobby.dart';
import 'package:szadogp/services/services.dart';

class SelectGameScreen extends ConsumerWidget {
  const SelectGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //wyslanie kody do api z wybrana gra i po sukcesie stworzenie pokoju i przejscie do jego ekranu
    selectGame(boardgameId) async {
      try {
        //funckja ktora wysyla do providera dane o calym lobby
        final lobbyData = await ApiServices().createGame(boardgameId);
        ref.read(lobbyDataProvider.notifier).state = lobbyData;
        //funkcja ktora wysyla do providera dane o aktualnym userze
        final userInfo = await ApiServices().getUserInfo();
        ref.read(userInfoProvider.notifier).state = userInfo;
        //funckja do wysylania body? do websoketa o stworzeniu lobby
        Map<String, dynamic> eventBody = {
          'roomId': lobbyData['roomId'],
          'userId': userInfo['_id'],
        };
        WebSocketSingleton().socket.emit('admin-join-game', eventBody);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        ref.read(currentScreenProvider.notifier).state = const LobbyScreen();
      } catch (err) {
        // ignore: use_build_context_synchronously
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          content: Text('$err'),
          backgroundColor: Colors.red,
        ));
      }
    }

    final boardgamesData = ref.watch(boardgamesDataProvider);

    return Scaffold(
        appBar: LogoAppbar(title: Image.asset('assets/images/logo.png', height: 30)),
        body: boardgamesData.when(
            data: (boardgamesList) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: boardgamesList.length, // list.length from data base
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        //on select game function
                        onTap: () => selectGame(boardgamesList[index]['_id']),
                        child: ImageRounded(imageUrl: boardgamesList[index]['imageUrl']),
                      );
                    }),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, s) {
              return Text('$err');
            }));
  }
}
