import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../home/presentation/manager/home_cubit.dart';

class UploadMyStoriesLoadingWidget extends StatelessWidget {
  const UploadMyStoriesLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildUserProfileImage(
          context,
          radius: 40.r,
          profileImage: HomeCubit.get(context).userModel!.profileImageUrl!,
        ),
        Text(
          'Uploading...',
          style: AppTextStyles.font14DarkBlueMedium,
        ),
      ],
    );
  }
}
