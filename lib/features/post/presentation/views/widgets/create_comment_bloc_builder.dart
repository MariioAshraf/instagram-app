import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import '../../../../../core/theming/app_colors.dart';

class CreateCommentBlocBuilder extends StatelessWidget {
  const CreateCommentBlocBuilder({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    PostCubit postCubit = PostCubit.get(context);
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state is CreateCommentSuccess) {
          postCubit.allPostsMap[postId]!.commentsCount++;
          postCubit.fetchComments(postId);
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
                  if (postCubit.commentController.text.isNotEmpty) {
                    await postCubit
                        .createComment(
                            userId: HomeCubit.get(context).userId,
                            postId: postId)
                        .whenComplete(() {
                      postCubit.commentController.clear();
                    });
                  }
                },
                icon: Icon(
                  Icons.send,
                  color: postCubit.commentController.text.isNotEmpty
                      ? AppColorsManager.mainBlue
                      : Colors.grey.shade400,
                ),
              );
      },
    );
  }
}
