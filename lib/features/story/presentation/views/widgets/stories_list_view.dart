import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/routing/routes.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/stories_list_view_builder.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/story_circle_item.dart';

import '../../../../auth/login/presentation/manager/login_cubit.dart';
import '../../../data/models/story_model.dart';

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
    userId = LoginCubit.get(context).userModel.uId!;
    storyCubit.getFriendsStories(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      buildWhen: (previous, current) => current is GetMyStoriesSuccess,
      builder: (context, state) {
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
                ...storyCubit.atLeastOneStoryNotSeenMap.entries.map((entry) {
                  final List<StoryModel> storiesListAtLeastOneNotSeen = entry
                      .value
                    ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
                  final storiesOwner =
                      storiesListAtLeastOneNotSeen.first.storyUserModel;

                  print('urlllllllllll== ${storiesOwner!.toJson()}');
                  final isStorySeen = storiesListAtLeastOneNotSeen
                      .map((story) => story.viewersIds!.containsKey(userId))
                      .toList();
                  // seenStories = storiesListAtLeastOneNotSeen
                  //     .where((story) => story.viewers.contains(userId))
                  //     .toList();
                  // unSeenStories = storiesListAtLeastOneNotSeen
                  //     .where((story) => !story.viewers.contains(userId))
                  //     .toList();
                  return Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<OutlinedBorder>(
                            const CircleBorder()),
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero),
                        overlayColor:
                            WidgetStateProperty.all<Color>(Colors.grey[400]!),
                      ),
                      onPressed: () {
                        context.pushNamed(
                          Routes.displayOnlineStoriesView,
                        );
                      },
                      child: StoryCircleItem(
                        key: ValueKey(isStorySeen),
                        name: storiesOwner.name,
                        profileImageUrl: storiesOwner.profileImageUrl,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class FriendsStoriesSection extends StatelessWidget {
//   const FriendsStoriesSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200.h,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           const StoryCircleItem(
//             name: 'My Story',
//             profileImageUrl: '',
//           ),
//           const StoryCircleItem(
//             name: 'My Story',
//             profileImageUrl: '',
//           ),
//           const StoryCircleItem(
//             name: 'My Story',
//             profileImageUrl: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
