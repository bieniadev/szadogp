import 'package:flutter/material.dart';

class SelectGameScreen extends StatelessWidget {
  const SelectGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Lista z wyborem gier')),
    );
  }
}
