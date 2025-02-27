import 'package:flutter/material.dart';
import 'package:instagram_app/core/routing/routes.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import '../../../../../constants.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import '../../manager/story_cubit/story_cubit.dart';
import 'DashedCircleAvatar.dart';

class HomeDisplayMyStoriesCircle extends StatelessWidget {
  const HomeDisplayMyStoriesCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = HomeCubit.get(context).userModel;
    final myStories = StoryCubit.get(context).myStories;
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(const CircleBorder()),
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        overlayColor: WidgetStateProperty.all<Color>(Colors.grey[400]!),
      ),
      onPressed: () {
        context.pushNamed(
          Routes.displayOfflineStoriesView,
          arguments: {
            kStoriesCollection: myStories,
            kIsMyStory: true,
          },
        );
      },
      child: DashedCircleAvatar(
        imageUrl: user.profileImageUrl!,
        name: user.name,
        dashCount: myStories.length,
      ),
    );
  }
}
