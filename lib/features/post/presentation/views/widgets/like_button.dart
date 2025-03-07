import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  double _scale = 1.0;

  void _animate() {
    setState(() => _scale = 0.8);
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _scale = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animate();
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_scale),
        child: Icon(
          widget.isLiked ? Icons.favorite : Icons.favorite_border,
          color: widget.isLiked ? Colors.red : Colors.black,
          size: 26.sp,
        ),
      ),
    );
  }
}
