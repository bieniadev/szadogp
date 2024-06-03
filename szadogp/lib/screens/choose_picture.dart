import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:szadogp/providers/choosen_image.dart';
import 'package:szadogp/providers/is_loading.dart';

class ChoosePictureScreen extends ConsumerStatefulWidget {
  const ChoosePictureScreen({super.key});

  @override
  ConsumerState<ChoosePictureScreen> createState() => ChoosePictureScreenState();
}

class ChoosePictureScreenState extends ConsumerState<ChoosePictureScreen> {
  XFile? _choosenImage;
  _chooseImageByGallery(WidgetRef ref) async {
    final XFile? returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    ref.read(isLoadingProvider.notifier).state = false;
    _choosenImage = returnedImage;
  }

  _chooseImageByTakingPhoto(WidgetRef ref) async {
    final XFile? returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    ref.read(isLoadingProvider.notifier).state = false;
    _choosenImage = returnedImage;
  }

  _confirmImage(WidgetRef ref) {
    ref.read(choosenImageProvider.notifier).state = _choosenImage;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppbar(title: Image.asset('assets/images/logo.png', height: 30)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _choosenImage == null
              ? const SizedBox(
                  height: 240,
                )
              : Container(
                  padding: const EdgeInsets.all(20),
                  width: 200,
                  height: 200,
                  child: Image.file(File(_choosenImage!.path)),
                ),
          const SizedBox(height: 30),
          ActionButton(onTap: () => _chooseImageByGallery(ref), hintText: 'Galeria', hasBorder: false),
          const SizedBox(height: 20),
          ActionButton(onTap: () => _chooseImageByTakingPhoto(ref), hintText: 'Zrób zdjęcie', hasBorder: false),
          _choosenImage != null ? const SizedBox(height: 20) : const SizedBox(height: 0, width: 0),
          _choosenImage != null ? ActionButton(onTap: () => _confirmImage(ref), hintText: 'Potwierdź', hasBorder: false) : const SizedBox(height: 0, width: 0),
        ],
      ),
    );
  }
}
