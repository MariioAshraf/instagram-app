import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/assets.dart';

class PostUserImageAndNameRow extends StatelessWidget {
  const PostUserImageAndNameRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          UserCircleProfileImage(
            radius: 30.r,
            imageUrl: AssetsData.defaultOnlineProfileImage,
          ),
          horizontalSpacing(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Mario Ashraf',
                    style: AppTextStyles.font16DarkBlueMedium,
                  ),
                  horizontalSpacing(4),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 18.r,
                  ),
                ],
              ),
              Text(
                '08:00',
                style: AppTextStyles.font12GreyRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
