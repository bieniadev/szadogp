import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:szadogp/providers/is_loading.dart';

class ActionButton extends ConsumerStatefulWidget {
  const ActionButton({
    super.key,
    required this.onTap,
    required this.hintText,
    required this.hasBorder,
  });

  final Function()? onTap;
  final String hintText;
  final bool hasBorder;

  @override
  ConsumerState<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends ConsumerState<ActionButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    _isLoading = ref.watch(isLoadingProvider);
    return !_isLoading
        ? GestureDetector(
            onTap: () {
              ref.read(isLoadingProvider.notifier).state = true;
              widget.onTap!();
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                boxShadow: !widget.hasBorder
                    ? const [
                        BoxShadow(offset: Offset(0, 4), color: Colors.black87, blurRadius: 5),
                        BoxShadow(offset: Offset(0, 4), color: Colors.black87, blurRadius: 5),
                      ]
                    : [],
                gradient: const LinearGradient(colors: [Color.fromARGB(255, 160, 50, 199), Color.fromARGB(255, 73, 19, 128)]),
                borderRadius: BorderRadius.circular(100),
                border: widget.hasBorder ? Border.all(color: Colors.black, width: 2) : null,
              ),
              child: Center(
                child: Text(
                  widget.hintText,
                  style: GoogleFonts.sigmarOne(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1, shadows: <Shadow>[
                    const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                    const Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                    const Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                    const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
                  ]),
                ),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              boxShadow: !widget.hasBorder
                  ? const [
                      BoxShadow(offset: Offset(0, 4), color: Colors.black87, blurRadius: 5),
                      BoxShadow(offset: Offset(0, 4), color: Colors.black87, blurRadius: 5),
                    ]
                  : [],
              gradient: const LinearGradient(colors: [Color.fromARGB(255, 160, 50, 199), Color.fromARGB(255, 73, 19, 128)]),
              borderRadius: BorderRadius.circular(100),
              border: widget.hasBorder ? Border.all(color: Colors.black, width: 2) : null,
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
            ),
          );
  }
}
