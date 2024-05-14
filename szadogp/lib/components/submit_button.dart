import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.onTap,
    required this.hintWidget,
  });

  final Function()? onTap;
  final Widget hintWidget;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isLoading = false; // to do: animacja loadingu po kliknieciu

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!();
        setState(() {
          _isLoading = !_isLoading;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(child: !_isLoading ? widget.hintWidget : const SizedBox(height: 29, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))),
      ),
    );
  }
}
