import 'package:flutter/material.dart';

class ImageRounded extends StatelessWidget {
  const ImageRounded({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 150,
        width: double.infinity,
      ),
    );
  }
}
