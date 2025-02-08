import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/story_circle_item.dart';
import '../../../../story/presentation/views/widgets/home_create_story_button.dart';

class StoriesListViewBuilder extends StatelessWidget {
  const StoriesListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200.h,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => index == 0
              ? const HomeCreateStoryButton()
              : const StoryCircleItem(),
        ),
      ),
    );
  }
}
