import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/routing/routes.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import '../../../../story/presentation/views/widgets/stories_list_view_builder.dart';
import 'home_create_post_container.dart';
import 'home_view_top_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: const CustomScrollView(
        slivers: [
          HomeViewTopBar(),
          HomeCreatePostContainer(),
          StoriesListViewBuilder(),
          PickStoryBlocListener(),
        ],
      ),
    );
  }
}

class PickStoryBlocListener extends StatelessWidget {
  const PickStoryBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocListener<StoryCubit, StoryState>(
        child: const SizedBox.shrink(),
        listener: (context, state) {
          if (state is StoryMediaPickedSuccess) {
            context.pushNamed(Routes.storyPreviewView);
          }
        },
      ),
    );
  }
}
