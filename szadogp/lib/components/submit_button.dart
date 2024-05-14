import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:szadogp/providers/is_loading.dart';

class SubmitButton extends ConsumerStatefulWidget {
  const SubmitButton({
    super.key,
    required this.onTap,
    required this.hintWidget,
  });

  final Function()? onTap;
  final Widget hintWidget;

  @override
  ConsumerState<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<SubmitButton> {
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
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(child: widget.hintWidget),
            ),
          )
        : const Padding(
            padding: EdgeInsets.only(top: 23),
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
          );
  }
}
