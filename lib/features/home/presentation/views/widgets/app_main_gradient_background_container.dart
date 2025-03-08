import 'package:flutter/material.dart';

class AppMainGradientBackgroundContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const AppMainGradientBackgroundContainer(
      {super.key, required this.child, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[50]!,
            Colors.white,
            Colors.white,
            Colors.blue[50]!
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.1, 0.2, 0.8, 0.9],
        ),
      ),
      child: child,
    );
  }
}
