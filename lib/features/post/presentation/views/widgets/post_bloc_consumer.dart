import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_item.dart';
import '../../manager/post_cubit.dart';

class PostBlocConsumer extends StatelessWidget {
  const PostBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    // final userId = HomeCubit.get(context).userId;
    final PostCubit postCubit = PostCubit.get(context);
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state is CreatePostSuccess) {
          // postCubit.fetchPosts(userId: userId);
        }
        if (state is GetPostsSuccess) {
          print('state.posts.length: ${state.posts.length}');
          state.posts.map((post) {
            if (!postCubit.allPostsMap.containsKey(post.postId)) {
              postCubit.allPostsMap[post.postId] = post;
            }
          }).toList();
        }
      },
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: postCubit.allPostsMap.length, (context, index) {
            return PostItem(
              postModel: postCubit.allPostsMap.values.toList()[index],
            );
          }),
        );
      },
    );
  }
}
