import 'package:flutter/material.dart';

class InputTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const InputTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5))),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
          filled: true,
          hintText: hintText,
        ),
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
