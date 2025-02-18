import 'package:flutter/material.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/story_circle_item.dart';
import '../../manager/story_cubit/story_cubit.dart';
import 'home_create_story_button.dart';
import 'home_display_my_stories_circle.dart';

class StoriesListViewBuilder extends StatelessWidget {
  const StoriesListViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final myStories = StoryCubit.get(context).myStories;
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => index == 0
          ? myStories.isEmpty
              ? const HomeCreateStoryButton()
              : HomeDisplayMyStoriesCircle(
                  index: index,
                )
          : StoryCircleItem(
              index: index,
            ),
    );
  }
}
