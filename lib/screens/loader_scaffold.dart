import 'package:flutter/material.dart';

class LoaderScaffold extends StatelessWidget {
  const LoaderScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
