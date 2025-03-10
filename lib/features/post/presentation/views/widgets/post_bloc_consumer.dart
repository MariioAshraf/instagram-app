import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_item.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_shimmer_loading.dart';
import '../../manager/post_cubit.dart';

class PostBlocConsumer extends StatefulWidget {
  const PostBlocConsumer({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<PostBlocConsumer> createState() => _PostBlocConsumerState();
}

class _PostBlocConsumerState extends State<PostBlocConsumer> {
  late PostCubit postCubit;

  @override
  void initState() {
    super.initState();
    postCubit = PostCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentPosition = widget.scrollController.position.pixels;
      final maxScroll = widget.scrollController.position.maxScrollExtent;

      if (postCubit.allPostsMap.isEmpty) {
        postCubit.fetchPosts(limit: 10, reset: true);
      } else {
        if (maxScroll > 0 && currentPosition >= 0.7 * maxScroll) {
          postCubit.fetchPosts(limit: 10, reset: true);
        }
      }
    });
  }

  // @override
  // void didChangeDependencies() {
  //   postCubit.fetchPosts(limit: 10, reset: true);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      buildWhen: (_, current) =>
          current is GetPostsSuccess ||
          current is GetPostsLoading ||
          current is FastToggleLike ||
          current is FetchLikesCountSuccess,
      listener: (context, state) {
        if (state is ToggleLikeSuccess) {
          PostCubit.get(context).fetchLikesCount(state.postId);
        }

        if (state is FetchLikesCountSuccess) {
          postCubit.allPostsMap[state.postId]!.likesCount = state.likesCount;
        }
        if (state is GetPostsSuccess) {
          state.posts.map((post) {
            if (!postCubit.allPostsMap.containsKey(post.postId)) {
              postCubit.allPostsMap[post.postId] = post;
            }
          }).toList();
        }
      },
      builder: (context, state) {
        if (state is GetPostsLoading) {
          return const PostShimmerLoading();
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: postCubit.allPostsMap.length, (context, index) {
            final post = postCubit.allPostsMap.values.toList()[index];
            final user = postCubit.postsUsers[post.uId];
            return PostItem(
              user: user!,
              post: post,
            );
          }),
        );
      },
    );
  }
}
