import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeInput extends ConsumerWidget {
  const CodeInput(
      {super.key, required this.controller, required this.onChanged});
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              gapPadding: 5,
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 4)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              gapPadding: 5,
              borderSide: const BorderSide(color: Colors.black, width: 4)),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
          labelStyle: const TextStyle(fontSize: 30, color: Colors.white),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(
            'PODAJ KOD',
            style: GoogleFonts.sigmarOne(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              shadows: <Shadow>[
                const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                const Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                const Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
              ],
            ),
          ),
        ),
        autocorrect: false,
        style: GoogleFonts.rubik(
            color: Colors.white,
            fontSize: 30,
            letterSpacing: 25,
            fontWeight: FontWeight.w600),
        maxLength: 6,
        showCursor: false,
      ),
    );
  }
}
