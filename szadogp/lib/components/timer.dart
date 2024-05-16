import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/providers/current_screen.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/summary_game.dart';
import 'package:szadogp/screens/home.dart';
import 'package:szadogp/services/services.dart';

class StopwatchTimer extends ConsumerStatefulWidget {
  const StopwatchTimer({super.key, required this.totalTime, required this.finishGame, required this.isAdmin, required this.gameId});

  final Duration totalTime;
  final Function(Duration val) finishGame;
  final bool isAdmin;
  final String gameId;

  @override
  ConsumerState<StopwatchTimer> createState() => _TimerState();
}

class _TimerState extends ConsumerState<StopwatchTimer> {
  String _timerValue = '';
  Duration _duration = const Duration();
  Timer? _timer;

// to do: ztestowac zegar w tle
// Stream<int> stopWatchStream() {
//   StreamController<int>? streamController;
//   Timer? timer;
//   int counter = 0;

//   void stopTimer() {
//     if (timer != null) {
//       timer!.cancel();
//       timer = null;
//       counter = 0;
//       streamController!.close();
//     }
//   }

//   void tick(_) {
//     counter++;
//     streamController!.add(counter);
//   }

//   void startTimer() {
//     timer = Timer.periodic(const Duration(milliseconds: 10), tick);
//   }

//   streamController = StreamController<int>(
//     onListen: startTimer,
//     onCancel: stopTimer,
//     onResume: startTimer,
//     onPause: stopTimer,
//   );

//   return streamController.stream;
// }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        final seconds = _duration.inSeconds + 1;

        _duration = Duration(seconds: seconds);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // print(_duration.inSeconds); // ile sekund zeby zapisac do bazy
    _timerValue = '${(_duration.inHours.toString()).padLeft(2, '0')}:${(_duration.inMinutes.remainder(60).toString()).padLeft(2, '0')}:${(_duration.inSeconds.remainder(60).toString()).padLeft(2, '0')}';
    return Column(
      children: [
        Text('CZAS', style: GoogleFonts.rubikMonoOne(fontSize: 36, fontWeight: FontWeight.bold)),
        Text(_timerValue, style: GoogleFonts.rubikMonoOne(fontSize: 36, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        widget.isAdmin
            ? ActionButton(
                onTap: () async {
                  try {
                    final Map<String, dynamic> response = await ApiServices().finishGame(widget.gameId);
                    ref.read(summaryGameProvider.notifier).state = response;

                    widget.finishGame(_duration);
                    _timer!.cancel();
                    ref.read(isLoadingProvider.notifier).state = false;
                  } catch (err) {
                    ref.read(isLoadingProvider.notifier).state = false;
                    throw Exception(err);
                  }
                },
                hintText: 'KONIEC',
                hasBorder: false,
              )
            : ActionButton(
                onTap: () async {
                  try {
                    //bambikowy kod dla wychodzenia z gry przez nie admina
                    final Map<String, dynamic> response = await ApiServices().checkIfGameEnded(widget.gameId);
                    if (response['redirect']!) {
                      ref.read(currentScreenProvider.notifier).state = const HomeScreen();
                    }
                    if (!response['redirect']!) {
                      ref.read(isLoadingProvider.notifier).state = false;
                      // ignore: use_build_context_synchronously
                      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text('Gra sie jescze nie skończyła'),
                        backgroundColor: Colors.red,
                      ));
                    }
                    _timer!.cancel();
                    ref.read(isLoadingProvider.notifier).state = false;
                  } catch (err) {
                    ref.read(isLoadingProvider.notifier).state = false;
                    throw Exception(err);
                  }
                },
                hintText: 'CZY KONIEC?',
                hasBorder: false,
              )
      ],
    );
  }
}
