import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import '../../../../../core/theming/app_colors.dart';
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
          'Create Story',
          style: AppTextStyles.font14DarkBlueMedium,
        ),
      ],
    );
  }
}

class PickStoryIcon extends StatelessWidget {
  const PickStoryIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final storyCubit = StoryCubit.get(context);
    return IconButton(
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
      ),
      color: AppColorsManager.mainBlue,
      onPressed: () {
        storyCubit.pickStoryMedia();
      },
      icon: CircleAvatar(
        backgroundColor: const Color(0xFFB1D5EA),
        radius: 50.r,
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColorsManager.mainBlue,
          child: CircleAvatar(
            backgroundColor: const Color(0xFFB1D5EA),
            radius: 16.r,
            child: const Icon(
              color: AppColorsManager.mainBlue,
              Icons.add,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
