import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:szadogp/components/action_button.dart';
import 'package:szadogp/components/logo_appbar.dart';
import 'package:szadogp/providers/is_loading.dart';
import 'package:szadogp/providers/selected_image.dart';

class PhotoConfirmationScreen extends ConsumerStatefulWidget {
  const PhotoConfirmationScreen({super.key, required this.selectedImage});

  final Uint8List selectedImage;

  @override
  ConsumerState<PhotoConfirmationScreen> createState() => _PhotoConfirmationScreenState();
}

class _PhotoConfirmationScreenState extends ConsumerState<PhotoConfirmationScreen> {
  Uint8List? _selectedImage;

  _reselectImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? selectedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedFile != null) {
      _selectedImage = await selectedFile.readAsBytes();
      // to do: selectedImage zapisac zdjecie gdzies
      ref.read(selectedImageProvider.notifier).state = _selectedImage;
      ref.read(isLoadingProvider.notifier).state = false;
    }
    ref.read(isLoadingProvider.notifier).state = false;
  }

  _uploadImage(WidgetRef ref) {
    //to do: wysylasz img do bazy i towrzy provider albo aktualizuje z userinfo o isntiejacym nowym image

    Navigator.pop(context);

    ref.read(selectedImageProvider.notifier).state = _selectedImage;

    ref.read(isLoadingProvider.notifier).state = false;
  }

  @override
  void initState() {
    super.initState();

    _selectedImage = widget.selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const LogoAppbar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: _selectedImage != null ? DecorationImage(image: MemoryImage(_selectedImage!), fit: BoxFit.cover) : null,
                ),
              ),
              const SizedBox(height: 20),
              ActionButton(onTap: () => _uploadImage(ref), hintText: 'Akceptuj', hasBorder: false),
              const SizedBox(height: 20),
              ActionButton(onTap: _reselectImage, hintText: 'Inny', hasBorder: false),
            ],
          ),
        ));
  }
}
