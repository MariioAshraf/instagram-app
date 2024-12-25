import 'package:flutter/material.dart';
import 'home_create_post_gradient_container.dart';
import 'home_create_post_pick_files_row.dart';
import 'home_create_post_user_image_and_text_file_row.dart';

class HomeCreatePostContainer extends StatelessWidget {
  const HomeCreatePostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: HomeCreatePostGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: HomeCreatePostUserImageAndTextFileRow(),
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
