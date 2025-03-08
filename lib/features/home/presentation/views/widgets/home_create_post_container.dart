import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_create_post_gradient_container.dart';
import 'home_create_post_pick_files_row.dart';
import 'home_create_post_user_image_and_text_row.dart';

class HomeCreatePostContainer extends StatelessWidget {
  const HomeCreatePostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: HomeCreatePostGradientContainer(
        height: 120.h,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: HomeCreatePostUserImageAndTextRow(),
            ),
            Expanded(
              child: HomeCreatePostPickFilesRow(),
            ),
          ],
        ),
      ),
    );
  }
}
