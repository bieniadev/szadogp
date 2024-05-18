import 'dart:typed_data';

import 'package:flutter/material.dart';

class DynamicImageAvatar extends StatefulWidget {
  const DynamicImageAvatar({
    super.key,
    required this.selectedImage,
  });

  final Uint8List? selectedImage;

  @override
  State<DynamicImageAvatar> createState() => _DynamicImageAvatarState();
}

class _DynamicImageAvatarState extends State<DynamicImageAvatar> {
  Uint8List? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: Colors.black),
        color: Colors.white,
        image: _selectedImage == null ? null : DecorationImage(image: MemoryImage(_selectedImage!), fit: BoxFit.cover), // to do: nie wyswietla sie odrazu po zmianie (trzeba wyjsc i wejsc)
      ),
    );
  }
}
