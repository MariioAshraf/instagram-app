import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_item.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_shimmer_loading.dart';
import '../../manager/get_post_cubit/get_post_cubit.dart';

class GetPostsBlocConsumer extends StatefulWidget {
  const GetPostsBlocConsumer({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<GetPostsBlocConsumer> createState() => _GetPostsBlocConsumerState();
}

class _GetPostsBlocConsumerState extends State<GetPostsBlocConsumer> {
  late GetPostCubit fetchPostCubit;

  @override
  void initState() {
    super.initState();
    fetchPostCubit = GetPostCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentPosition = widget.scrollController.position.pixels;
      final maxScroll = widget.scrollController.position.maxScrollExtent;

      if (fetchPostCubit.allPostsMap.isEmpty) {
        fetchPostCubit.fetchPosts(limit: 10, reset: true);
      } else {
        if (maxScroll > 0 && currentPosition >= 0.7 * maxScroll) {
          fetchPostCubit.fetchPosts(limit: 10, reset: true);
        }
      }
    });
  }

  // @override
  // void didChangeDependencies() {
  //   fetchPostCubit.fetchPosts(limit: 10, reset: true);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    return BlocConsumer<GetPostCubit, GetPostState>(
      buildWhen: (_, current) =>
          current is GetPostsSuccess ||
          current is GetPostsLoading ||
          current is FastToggleLike ||
          current is FetchLikesCountSuccess,
      listener: (context, state) {
        if (state is ToggleLikeSuccess) {
          fetchPostCubit.fetchLikesCount(state.postId);
        }

        if (state is FetchLikesCountSuccess) {
          homeCubit.homePostsMap[state.postId]!.likesCount = state.likesCount;
        }
        if (state is GetPostsSuccess) {
          state.posts.map((post) {
            homeCubit.homePostsMap[post.postId] = post;
            fetchPostCubit.allPostsMap = homeCubit.homePostsMap;
          }).toList();
        }
      },
      builder: (context, state) {
        if (state is GetPostsLoading) {
          return const PostShimmerLoading();
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: homeCubit.homePostsMap.length, (context, index) {
            final posts = homeCubit.homePostsMap.values.toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
            final user = fetchPostCubit.postsUsers[posts[index].uId];
            return PostItem(
              user: user!,
              post: posts[index],
            );
          }),
        );
      },
    );
  }
}
