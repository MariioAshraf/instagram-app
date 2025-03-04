import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.child,
    this.onPressed,
    this.splashColor,
  });

  final Widget child;
  final Color? splashColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(splashColor ?? Colors.grey[200]),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      ),
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: child,
    );
  }
}
