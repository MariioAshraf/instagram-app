import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';

class StoryCircleItem extends StatelessWidget {
  const StoryCircleItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColorsManager.mainBlue,
            radius: 45.r,
            child: UserCircleProfileImage(
              radius: 42.5.r,
              imageUrl:
                  'https://gratisography.com/wp-content/uploads/2024/11/gratisography-augmented-reality-800x525.jpg',
            ),
          ),
          verticalSpacing(10),
          Text(
            'Story',
            style: AppTextStyles.font14DarkBlueMedium,
          ),
        ],
      ),
    );
  }
}
