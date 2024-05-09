import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.onTap, required this.hintText});

  final Function()? onTap;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color.fromARGB(255, 160, 50, 199), Color.fromARGB(255, 73, 19, 128)]),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Center(
          child: Text(
            hintText,
            style: GoogleFonts.sigmarOne(
              fontSize: 26,
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
      ),
    );
  }
}
