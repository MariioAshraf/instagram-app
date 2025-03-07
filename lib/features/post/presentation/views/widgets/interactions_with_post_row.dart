import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/utils/assets.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_icon_button.dart';
import 'like_button.dart';

class InteractionsWithPostRow extends StatelessWidget {
  const InteractionsWithPostRow({
    super.key,
    required this.index,
    required this.likesNum,
    required this.commentsNum,
  });

  final int likesNum;
  final int index;
  final int commentsNum;

  @override
  Widget build(BuildContext context) {
    final PostCubit postCubit = PostCubit.get(context);
    final List<String> postIds = postCubit.allPostsMap.keys.toList();
    final bool isLiked = postCubit.likedPostsMap.containsKey(postIds[index]);
    final String userId = HomeCubit.get(context).userId;
    return Row(
      children: [
        LikeButton(
          isLiked: isLiked,
          onTap: () {
            postCubit.toggleLike(postIds[index], userId);
          },
        ),
        Text(likesNum.toString()),
        horizontalSpacing(16),
        GestureDetector(
          onTap: () {},
          child: Icon(
            size: 23.sp,
            Icons.mode_comment_outlined,
            color: Colors.black,
          ),
        ),
        horizontalSpacing(2),
        Text(commentsNum.toString()),
        horizontalSpacing(16),
        AppIconButton(
          onPressed: () {},
          splashColor: Colors.transparent,
          child: Image.asset(
            AssetsData.shareIcon,
            height: 20.sp,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.bookmark_border_rounded,
          color: Colors.black,
          size: 24.sp,
        ),
      ],
    );
  }
}
