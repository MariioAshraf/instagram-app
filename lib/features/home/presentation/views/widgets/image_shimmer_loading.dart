import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ImageShimmerLoading extends StatelessWidget {
  const ImageShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white.withOpacity(.5),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}