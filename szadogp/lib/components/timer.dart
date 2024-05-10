import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

String timerValue = '00:21:12';

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('CZAS',
            style: GoogleFonts.rubikMonoOne(
                fontSize: 36, fontWeight: FontWeight.bold)),
        Text(timerValue,
            style: GoogleFonts.rubikMonoOne(
                fontSize: 36, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
