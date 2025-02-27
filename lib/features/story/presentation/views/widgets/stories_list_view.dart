import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/my_stories_section.dart';
import '../../../../auth/login/presentation/manager/login_cubit.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import 'friends_stories_section.dart';

class StoriesListView extends StatefulWidget {
  const StoriesListView({super.key});

  @override
  State<StoriesListView> createState() => _StoriesListViewState();
}

class _StoriesListViewState extends State<StoriesListView> {
  final String preventRebuildIssueWithConst = 'rebuild issue';
  late StoryCubit storyCubit;
  late String userId;

  @override
  void initState() {
    storyCubit = StoryCubit.get(context);
    userId = HomeCubit.get(context).userModel.uId!;
    storyCubit.getFriendsStories(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200.h,
        width: double.maxFinite,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            MyStoriesSection(
              preventRebuildIssueWithConst: preventRebuildIssueWithConst,
            ),
            const FriendsStoriesSection(),
          ],
        ),
      ),
    );
  }
}
