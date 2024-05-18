import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:szadogp/components/user-stats/drawer/drawer_tile.dart';
import 'package:szadogp/components/user-stats/drawer/photo_display.dart';
import 'package:szadogp/providers/is_loading.dart';

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
    selectImage() async {
      final ImagePicker imagePicker = ImagePicker();
      XFile? selectedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (selectedFile != null) {
        Uint8List selectedImage = await selectedFile.readAsBytes();
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhotoConfirmationScreen(selectedImage: selectedImage)));
        ref.read(isLoadingProvider.notifier).state = false;
      }
      ref.read(isLoadingProvider.notifier).state = false;
    }

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
                  style: GoogleFonts.rubikMonoOne(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black.withOpacity(0.15),
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    DrawerTile(
                      icon: Icons.account_box,
                      text: 'Zmień zdjęcie profilowe',
                      onTap: selectImage,
                    ),
                    const Divider(height: 0, endIndent: 15, indent: 15),
                    DrawerTile(
                      icon: Icons.image_rounded,
                      text: 'Zmień zdjęcie w tle',
                      onTap: () {},
                    ),
                    const Spacer(),
                    ActionButton(
                      onTap: logOut,
                      hintText: 'Wyloguj',
                      hasBorder: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
