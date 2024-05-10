import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';

class StopwatchTimer extends ConsumerStatefulWidget {
  const StopwatchTimer({super.key, required this.totalTime, required this.finishGame, required this.isAdmin});

  final Duration totalTime;
  final Function(Duration val) finishGame;
  final bool isAdmin;

  @override
  ConsumerState<StopwatchTimer> createState() => _TimerState();
}

class _TimerState extends ConsumerState<StopwatchTimer> {
  String _timerValue = '';
  Duration _duration = const Duration();

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (_) {
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
        const SizedBox(height: 30),
        widget.isAdmin
            ? ActionButton(
                onTap: () => widget.finishGame(_duration),
                hintText: 'KONIEC',
                hasBorder: false,
              )
            : const SizedBox(height: 0),
      ],
    );
  }
}
