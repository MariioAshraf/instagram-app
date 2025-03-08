import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/theming/app_styles.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/post/data/models/comment_model.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import '../../../../../core/utils/format_date_time.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../home/presentation/views/widgets/home_create_post_gradient_container.dart';

class CommentsListViewBuilder extends StatelessWidget {
  const CommentsListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      buildWhen: (previous, current) =>
          current is FetchCommentsSuccess ||
          current is FetchCommentsFailure ||
          current is FetchCommentsLoading,
      builder: (context, state) {
        return state is FetchCommentsSuccess
            ? Expanded(
                child: ListView.builder(
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    return CommentItem(
                      commentModel: state.comments[index],
                    );
                  },
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.commentModel});

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    final PostCubit postCubit = PostCubit.get(context);
    final user = postCubit.postsUsers[commentModel.userId]!;
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
