import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';

class UserSettingsPanel extends ConsumerWidget {
  const UserSettingsPanel({
    super.key,
    required this.userInfo,
    required this.logOut,
  });

  final Map<String, dynamic> userInfo;
  final Function() logOut;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
        width: 260,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 55),
                child: Text(
                  '${userInfo['username']}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black.withOpacity(0.15),
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: SizedBox(
                    height: 70,
                    child: Center(
                      child: ActionButton(
                        onTap: logOut,
                        hintText: 'Wyloguj',
                        hasBorder: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
