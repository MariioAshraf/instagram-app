import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/post/data/models/post_model.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_image_container.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import '../../../../post/presentation/views/widgets/post_title.dart';
import '../../../../post/presentation/views/widgets/post_user_image_and_name_row.dart';
import 'interactions_with_post_row.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
    required this.user,
  });

  final PostModel post;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    final userModel = user.uId == homeCubit.userId ? homeCubit.userModel : user;
    return Container(
        margin: EdgeInsets.only(
          bottom: 10.h,
          right: 2.w,
          left: 2.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostUserImageAndNameRow(
              createdAt: post.createdAt,
              userImage: userModel!.profileImageUrl!,
              userName: userModel.name,
            ),
            verticalSpacing(10),
            PostTitle(
              text: post.postTitle!,
            ),
            verticalSpacing(10),
            PostImageContainer(
              postImages: post.postFileUrl!,
            ),
            verticalSpacing(10),
            InteractionsWithPostRow(
              postId: post.postId,
              likesNum: post.likesCount,
              commentsNum: post.commentsCount,
            ),
          ],
        ));
  }
}
