import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/pick_story_icon.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../manager/story_cubit/story_cubit.dart';

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
