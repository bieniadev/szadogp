import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/user-stats/user_card_rounded.dart';

class UserStats extends StatelessWidget {
  const UserStats({super.key, required this.eloPoints});

  final int eloPoints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: UserCardRounded(
              child: Text(
                'ELO: $eloPoints',
                style: GoogleFonts.rubik(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: UserCardRounded(
                    child: Text(
                  'Sub karta',
                  style: GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.w400),
                )),
              ),
              Expanded(
                child: UserCardRounded(
                    child: Text(
                  'Sub karta',
                  style: GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.w400),
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
