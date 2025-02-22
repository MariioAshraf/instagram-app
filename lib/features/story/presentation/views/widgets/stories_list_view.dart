import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/stories_list_view_builder.dart';

class StoriesListView extends StatelessWidget {
  const StoriesListView({super.key});

  final String preventRebuildIssueWithConst = 'rebuild issue';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      buildWhen: (previous, current) => current is GetMyStoriesSuccess,
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 200.h,
            width: double.maxFinite,
            child: StoriesListViewBuilder(
              preventRebuildIssueWithConst: preventRebuildIssueWithConst,
            ),
          ),
        );
      },
    );
  }
}
