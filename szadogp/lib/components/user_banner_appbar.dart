import 'package:flutter/material.dart';

class UserBannerAppbar extends StatelessWidget implements PreferredSizeWidget {
  const UserBannerAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), // powrot do HomeScreen
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
            size: 32,
            shadows: <Shadow>[
              Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
              Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
              Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
              Shadow(offset: Offset(-1.5, 1.5), color: Colors.black)
            ],
          )),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
