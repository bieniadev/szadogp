import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserBanner extends StatelessWidget {
  const UserBanner({super.key, required this.username});
  final String username;
  @override
  Widget build(BuildContext context) {
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
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2, color: Colors.black),
                    color: Colors.white,
                    // image: haveImg ? const DecorationImage(image: AssetImage('')) : const DecorationImage(image: NetworkImage('https://image-cdn-ak.spotifycdn.com/image/ab67706c0000da846233be8bdc5bd72fc2716811'), fit: BoxFit.cover), // to do: zmienna/link do zdj
                    image: const DecorationImage(image: AssetImage(''), fit: BoxFit.cover), // to do: zmienna/link do zdj
                  ),
                ),
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
