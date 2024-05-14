import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeDisplayer extends StatelessWidget {
  const CodeDisplayer({
    super.key,
    required Map<String, dynamic> lobbyData,
  }) : _lobbyData = lobbyData;

  final Map<String, dynamic> _lobbyData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: const Color.fromARGB(255, 49, 49, 49),
            ),
            child: Text(
              _lobbyData['code'],
              style: GoogleFonts.rubik(
                letterSpacing: 20,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                shadows: <Shadow>[
                  const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                  const Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                  const Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                  const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
                ],
              ),
            ),
          ),
          Text(
            'CODE',
            style: GoogleFonts.rubikMonoOne(
              fontSize: 28,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              shadows: <Shadow>[
                const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                const Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                const Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
