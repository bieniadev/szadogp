import 'package:flutter/material.dart';

class UserCardRounded extends StatelessWidget {
  const UserCardRounded({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1, color: Color.fromARGB(255, 96, 96, 96)),
            borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: child,
          ),
        ),
      ),
    );
  }
}
