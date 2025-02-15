import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/pick_story_icon.dart';
import '../../../../../core/theming/app_styles.dart';

class HomeCreateStoryButton extends StatelessWidget {
  const HomeCreateStoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PickStoryIcon(),
        verticalSpacing(10),
        Text(
          'Your Story',
          style: AppTextStyles.font14DarkBlueMedium,
        ),
      ],
    );
  }
}
