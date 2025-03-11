import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import '../../manager/story_cubit/story_cubit.dart';
import 'home_create_story_button.dart';
import 'home_display_my_stories_circle.dart';

class MyStoriesSection extends StatefulWidget {
  const MyStoriesSection({
    super.key,
    required this.preventRebuildIssueWithConst,
  });

  final String preventRebuildIssueWithConst;

  @override
  State<MyStoriesSection> createState() => _MyStoriesSectionState();
}

class _MyStoriesSectionState extends State<MyStoriesSection> {
  @override
  void initState() {
    StoryCubit.get(context)
        .getMyStories(HomeCubit.get(context).userModel!.uId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      buildWhen: (previous, current) => current is GetMyStoriesSuccess,
      builder: (context, state) {
        return StoryCubit.get(context).myStories.isEmpty
            ? const HomeCreateStoryButton()
            : const HomeDisplayMyStoriesCircle();
      },
    );
  }
}
