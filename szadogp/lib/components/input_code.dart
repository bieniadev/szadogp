import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodeInput extends ConsumerWidget {
  const CodeInput(
      {super.key, required this.controller, required this.onChanged});
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              gapPadding: 5,
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 4)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              gapPadding: 5,
              borderSide: const BorderSide(color: Colors.black, width: 4)),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.4),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
          labelStyle: const TextStyle(fontSize: 30, color: Colors.white),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: const Text('PODAJ KOD'),
        ),
        autocorrect: false,
        style: const TextStyle(
            color: Colors.white, fontSize: 30, letterSpacing: 25),
        maxLength: 6,
        showCursor: false,
      ),
    );
  }
}
