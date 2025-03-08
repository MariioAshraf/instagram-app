import 'package:flutter/material.dart';

class HomeCreatePostGradientContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const HomeCreatePostGradientContainer(
      {super.key, required this.child, this.height, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.blue[100]!.withAlpha(145),
            Colors.blue[50]!.withAlpha(120),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [
            0.2,
            0.7,
          ],
        ),
      ),
      child: child,
    );
  }
}
