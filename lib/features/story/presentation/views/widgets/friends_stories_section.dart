import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/routing/routes.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import '../../../../../constants.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import '../../../data/models/story_model.dart';
import 'dashed_circle_avatar.dart';

class FriendsStoriesSection extends StatelessWidget {
  const FriendsStoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final storyCubit = StoryCubit.get(context);
    final userId = HomeCubit.get(context).userModel!.uId!;
    return BlocBuilder<StoryCubit, StoryState>(
      buildWhen: (previous, current) => current is GetFriendsStoriesSuccess,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...storyCubit.atLeastOneStoryNotSeenMap.entries.map((entry) {
              final List<StoryModel> storiesListAtLeastOneNotSeen = entry.value
                ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
              final storiesOwner =
                  storiesListAtLeastOneNotSeen.first.storyUserModel;
              final isStorySeen = storiesListAtLeastOneNotSeen
                  .map((story) => story.seenStoryDate!.containsKey(userId))
                  .toList();
              return Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                          const CircleBorder()),
                      padding:
                          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                      overlayColor:
                          WidgetStateProperty.all<Color>(Colors.grey[400]!),
                    ),
                    onPressed: () {
                      context.pushNamed(
                        Routes.displayOnlineStoriesView,
                        arguments: storiesListAtLeastOneNotSeen,
                      );
                    },
                    child: DashedCircleAvatar(
                      key: ValueKey(isStorySeen),
                      storiesStates: isStorySeen,
                      name: storiesOwner!.name,
                      imageUrl: storiesOwner.profileImageUrl!,
                      dashCount: storiesListAtLeastOneNotSeen.length,
                    ),
                  ),
                ),
              );
            }),
            ...storyCubit.storiesMapAllSeenBefore.entries.map((entry) {
              final List<StoryModel> storiesList = entry.value
                ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
              return Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<OutlinedBorder>(
                          const CircleBorder()),
                      padding:
                          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                      overlayColor:
                          WidgetStateProperty.all<Color>(Colors.grey[400]!),
                    ),
                    onPressed: () {
                      context.pushNamed(
                        Routes.displayOfflineStoriesView,
                        arguments: {
                          kStoriesCollection: storiesList,
                          kIsMyStory: false,
                        },
                      );
                    },
                    child: DashedCircleAvatar(
                      imageUrl: storiesList[0].storyUserModel!.profileImageUrl!,
                      dashCount: storiesList.length,
                      name: storiesList[0].storyUserModel!.name,
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
