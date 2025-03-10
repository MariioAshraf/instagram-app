import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/theming/app_styles.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/post/data/models/comment_model.dart';
import '../../../../../core/utils/format_date_time.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../home/presentation/views/widgets/home_create_post_gradient_container.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.commentModel});

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    final HomeCubit postCubit =HomeCubit.get(context);
    final user = postCubit.allUsersMap[commentModel.userId]!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildUserProfileImage(context, profileImage: user.profileImageUrl!),
        horizontalSpacing(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Name & Timestamp
              HomeCreatePostGradientContainer(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                // height: 60.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name[0].toUpperCase()}${user.name.substring(1)}',
                      style: AppTextStyles.font16BlackBold,
                    ),
                    Text(
                      commentModel.comment,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              verticalSpacing(4),
              Text(
                formatDateTime(commentModel.createdAt),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
