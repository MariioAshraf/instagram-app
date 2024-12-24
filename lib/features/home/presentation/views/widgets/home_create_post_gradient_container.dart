import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCreatePostGradientContainer extends StatelessWidget {
  final Widget child;

  const HomeCreatePostGradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: double.maxFinite,
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
