import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SummarySection extends ConsumerWidget {
  const SummarySection({super.key, required this.text, required this.widget});

  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: GoogleFonts.rubikMonoOne(
                fontSize: 20, fontWeight: FontWeight.w800)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 81, 81, 81).withOpacity(0.3),
                borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: widget,
            ),
          ),
        ),
      ],
    );
  }
}
