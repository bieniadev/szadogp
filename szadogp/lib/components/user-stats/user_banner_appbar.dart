import 'package:flutter/material.dart';
import 'package:szadogp/components/user-stats/user_banner.dart';

class UserBannerAppbar extends StatelessWidget implements PreferredSizeWidget {
  const UserBannerAppbar({super.key, required this.scaffoldKey, required this.username});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String username;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 200,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: UserBanner(username: username),
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 140),
        child: IconButton(
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
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140),
          child: IconButton(
              onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
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
              )),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
