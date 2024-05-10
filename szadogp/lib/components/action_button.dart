import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onTap,
    required this.hintText,
    required this.hasBorder,
  });

  final Function()? onTap;
  final String hintText;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          boxShadow: !hasBorder
              ? const [
                  BoxShadow(
                      offset: Offset(0, 4),
                      color: Colors.black87,
                      blurRadius: 5),
                  BoxShadow(
                      offset: Offset(0, 4),
                      color: Colors.black87,
                      blurRadius: 5),
                ]
              : [],
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 160, 50, 199),
            Color.fromARGB(255, 73, 19, 128)
          ]),
          borderRadius: BorderRadius.circular(100),
          border: hasBorder ? Border.all(color: Colors.black, width: 2) : null,
        ),
        child: Center(
          child: Text(
            hintText,
            style: GoogleFonts.sigmarOne(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                shadows: <Shadow>[
                  const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                  const Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                  const Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                  const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
                ]),
          ),
        ),
      ),
    );
  }
}
