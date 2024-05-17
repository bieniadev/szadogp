import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:szadogp/components/action_button.dart';

class PhotoConfirmationScreen extends StatefulWidget {
  const PhotoConfirmationScreen({super.key, required this.selectedImage});

  final Uint8List selectedImage;

  @override
  State<PhotoConfirmationScreen> createState() => _PhotoConfirmationScreenState();
}

class _PhotoConfirmationScreenState extends State<PhotoConfirmationScreen> {
  Uint8List? _selectedImage;

  _selectImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? selectedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedFile != null) {
      Uint8List pickedImage = await selectedFile.readAsBytes();
      setState(() {
        _selectedImage = pickedImage;
      });
      print('SELECTED IMAGE: $_selectedImage'); // to do: zapisac zdjecie gdzies

      // ignore: use_build_context_synchronously
    }
    print('nic nie wybrano');
  }

  _uploadImage() {
    //to do: wysylasz img do bazy i towrzy provider albo aktualizuje z userinfo o isntiejacym nowym image
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    _selectedImage = widget.selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: _selectedImage != null ? DecorationImage(image: MemoryImage(_selectedImage!)) : const DecorationImage(image: const AssetImage('')),
            ),
          ),
          Row(
            children: [
              ActionButton(onTap: _uploadImage, hintText: 'Akceptuj', hasBorder: false),
              ActionButton(onTap: _selectImage, hintText: 'Jeszcze raz', hasBorder: false),
            ],
          )
        ],
      )),
    );
  }
}
