import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:szadogp/providers/selected_image.dart';

class DynamicImageAvatar extends ConsumerStatefulWidget {
  const DynamicImageAvatar({super.key});

  @override
  ConsumerState<DynamicImageAvatar> createState() => _DynamicImageAvatarState();
}

class _DynamicImageAvatarState extends ConsumerState<DynamicImageAvatar> {
  Uint8List? _selectedImage;

  @override
  Widget build(BuildContext context) {
    _selectedImage = ref.read(selectedImageProvider);

    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: Colors.black),
        color: Colors.white,
        image: ref.watch(selectedImageProvider) == null ? null : DecorationImage(image: MemoryImage(_selectedImage!), fit: BoxFit.cover),
      ),
    );
  }
}
