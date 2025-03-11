import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/post/presentation/manager/comment_cubit/comment_cubit.dart';
import '../../../../../core/theming/app_colors.dart';

class CreateCommentBlocConsumer extends StatelessWidget {
  const CreateCommentBlocConsumer({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context) {
    Map users = HomeCubit.get(context).allUsersMap;
    CommentCubit commentCubit = CommentCubit.get(context);
    return BlocConsumer<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is CreateCommentSuccess) {
          HomeCubit.get(context).homePostsMap[postId]!.commentsCount++;
          commentCubit.fetchComments(postId, users);
        }
      },
      buildWhen: (previous, current) =>
          current is CreateCommentSuccess ||
          current is CreateCommentFailure ||
          current is CreateCommentLoading ||
          current is CanComment ||
          current is CanNotComment,
      builder: (context, state) {
        return state is CreateCommentLoading
            ? const CircularProgressIndicator(
                color: AppColorsManager.mainBlue,
                strokeWidth: 2,
              )
            : IconButton(
                onPressed: () async {
                  if (commentCubit.commentController.text.isNotEmpty) {
                    await commentCubit
                        .createComment(
                            userId: HomeCubit.get(context).userId!,
                            postId: postId)
                        .whenComplete(() {
                      commentCubit.commentController.clear();
                    });
                  }
                },
                icon: Icon(
                  Icons.send,
                  color: commentCubit.commentController.text.isNotEmpty
                      ? AppColorsManager.mainBlue
                      : Colors.grey.shade400,
                ),
              );
      },
    );
  }
}
