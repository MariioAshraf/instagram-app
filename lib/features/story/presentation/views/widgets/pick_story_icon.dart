import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import '../../../../../core/theming/app_colors.dart';

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
      icon: Stack(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFB1D5EA),
            radius: 45.r,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: 21.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColorsManager.mainBlue,
                child: const Icon(
                  color: Colors.white,
                  Icons.add,
                  size: 28,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
