import 'package:flutter/material.dart';

class UserBannerAppbar extends StatelessWidget implements PreferredSizeWidget {
  const UserBannerAppbar({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), // powrot do HomeScreen
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 32,
            shadows: <Shadow>[
              Shadow(offset: Offset(-1, -1), color: Colors.black),
              Shadow(offset: Offset(1, -1), color: Colors.black),
              Shadow(offset: Offset(1, 1), color: Colors.black),
              Shadow(offset: Offset(-1, 1), color: Colors.black),
            ],
          )),
      actions: [
        IconButton(
            onPressed: () => scaffoldKey.currentState!.openDrawer(),
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 32,
              shadows: <Shadow>[
                Shadow(offset: Offset(-1, -1), color: Colors.black),
                Shadow(offset: Offset(1, -1), color: Colors.black),
                Shadow(offset: Offset(1, 1), color: Colors.black),
                Shadow(offset: Offset(-1, 1), color: Colors.black),
              ],
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
