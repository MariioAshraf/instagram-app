import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_item.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_shimmer_loading.dart';

import '../../manager/get_post_cubit/get_post_cubit.dart';

class GetPostsBlocConsumer extends StatefulWidget {
  const GetPostsBlocConsumer({
    super.key,
  });

  @override
  State<GetPostsBlocConsumer> createState() => _GetPostsBlocConsumerState();
}

class _GetPostsBlocConsumerState extends State<GetPostsBlocConsumer> {
  late GetPostCubit _getPostsCubit;
  late HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = HomeCubit.get(context);
    _getPostsCubit = GetPostCubit.get(context);
    _initializeData();
    super.initState();
  }

  _initializeData() async {
    if (_getPostsCubit.allPostsMap.isEmpty) {
      await _getPostsCubit.fetchPosts(userId: _homeCubit.userId!, reset: true);
    }
  }

  @override
  void didChangeDependencies() {
    _initializeData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final homePostsMap = _homeCubit.homePostsMap;
    return BlocConsumer<GetPostCubit, GetPostState>(
      buildWhen: (_, current) =>
          current is GetPostsSuccess ||
          current is GetPostsLoading ||
          current is FastToggleLike ||
          current is NoMorePosts ||
          current is GetPostsPaginationLoading,
      listener: (context, state) {
        if (state is FastToggleLike) {
          state.like
              ? homePostsMap[state.postId]!.likesCount++
              : homePostsMap[state.postId]!.likesCount--;
        }
        if (state is GetPostsSuccess) {
          state.posts.map((post) {
            homePostsMap[post.postId] = post;
            _getPostsCubit.allPostsMap = homePostsMap;
          }).toList();
        }
      },
      builder: (context, state) {
        if (state is NoMorePosts && homePostsMap.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('No posts yet'),
            ),
          );
        }
        if (state is GetPostsLoading) {
          return const PostShimmerLoading();
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(childCount: homePostsMap.length,
              (context, index) {
            final posts = homePostsMap.values.toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
            UserModel? user = _getPostsCubit.postsUsers[posts[index].uId];
            user ??= _homeCubit.allUsersMap[posts[index].uId];
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
