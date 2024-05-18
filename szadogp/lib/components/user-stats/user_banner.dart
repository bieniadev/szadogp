import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/user-stats/dynamic_user_display.dart';

class UserBanner extends ConsumerWidget {
  const UserBanner({super.key, required this.username});
  final String username;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDNbidSXapy9W0xfbOBvI_SLjnFkP2ln9Spe43IG4Biw&s', // to do: custom image background
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const DynamicImageAvatar(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    username,
                    style: GoogleFonts.comicNeue(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      shadows: <Shadow>[const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black), const Shadow(offset: Offset(1.5, -1.5), color: Colors.black), const Shadow(offset: Offset(1.5, 1.5), color: Colors.black), const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
