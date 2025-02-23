import 'package:flutter/material.dart';
import '../../manager/story_cubit/story_cubit.dart';
import 'home_create_story_button.dart';
import 'home_display_my_stories_circle.dart';

class MyStoriesSection extends StatelessWidget {
  const MyStoriesSection({
    super.key,
    required this.preventRebuildIssueWithConst,
  });

  final String preventRebuildIssueWithConst;

  @override
  Widget build(BuildContext context) {
    return StoryCubit.get(context).myStories.isEmpty
        ? const HomeCreateStoryButton()
        : const HomeDisplayMyStoriesCircle();
  }
}
