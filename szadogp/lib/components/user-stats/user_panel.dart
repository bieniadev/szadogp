import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:szadogp/providers/user_data.dart';
import 'package:szadogp/screens/user_stats.dart';

class UserPanel extends ConsumerWidget {
  const UserPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const UserStatsScreen(),
      )),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 47, 41, 60),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 60,
                  color: Colors.black38,
                ),
              ),
              userData.when(
                data: (data) {
                  Hive.box('user-token').put(2, data);

                  return Text(
                    data['username'],
                    style: GoogleFonts.comicNeue(fontSize: 26, fontWeight: FontWeight.bold),
                  );
                },
                loading: () => const Text('Wszytywanie...'),
                error: (e, s) => const Text('err'),
              ),
              //   Text('USERNAME', style: GoogleFonts.comicNeue(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(width: 60)
            ],
          ),
        ),
      ),
    );
  }
}
