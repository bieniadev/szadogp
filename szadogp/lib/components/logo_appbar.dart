import 'package:flutter/material.dart';

class LogoAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LogoAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/images/logo.png', height: 30),
      centerTitle: true,
      elevation: 5,
      backgroundColor: const Color.fromARGB(255, 60, 52, 77),
      iconTheme: const IconThemeData(color: Colors.white, size: 30),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: const [0.05, 0.55],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                const Color.fromARGB(255, 191, 77, 193).withOpacity(0.25),
                const Color.fromARGB(255, 13, 4, 49).withOpacity(0.25),
              ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
