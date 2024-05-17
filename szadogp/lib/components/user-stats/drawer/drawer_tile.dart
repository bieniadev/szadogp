import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({super.key, required this.icon, required this.text, required this.onTap});

  final IconData? icon;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).primaryColor,
      contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 10),
      leading: Icon(icon, size: 36, color: Colors.white70),
      title: Text(text, style: GoogleFonts.rubik(color: Colors.white70, fontSize: 12)),
      onTap: onTap,
    );
  }
}
