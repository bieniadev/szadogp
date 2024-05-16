import 'package:flutter/material.dart';

class InputTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  const InputTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    required this.textInputAction,
  });

  @override
  State<InputTextfield> createState() => _InputTextfieldState();
}

class _InputTextfieldState extends State<InputTextfield> {
  bool _passVisible = true;

  void changeVisibility() {
    setState(() {
      _passVisible = !_passVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: !widget.obscureText ? widget.obscureText : _passVisible,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: changeVisibility,
                  icon: _passVisible
                      ? const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.visibility_off,
                            size: 26,
                            color: Colors.white60,
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.visibility,
                            size: 26,
                            color: Colors.white54,
                          ),
                        ))
              : const SizedBox(height: 0),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 96, 96, 96))),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
