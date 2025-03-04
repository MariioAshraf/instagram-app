import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import '../../../../post/presentation/views/widgets/post_bloc_consumer.dart';
import '../../../../post/presentation/views/widgets/post_item.dart';
import '../../../../story/presentation/views/widgets/stories_list_view.dart';
import '../../manager/home_cubit.dart';
import 'home_create_post_container.dart';
import 'home_view_top_bar.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

late String userId;

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    userId = HomeCubit.get(context).userId;
    PostCubit.get(context).fetchPosts(limit: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PostCubit postCubit = PostCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: const CustomScrollView(
        slivers: [
          HomeViewTopBar(),
          HomeCreatePostContainer(),
          StoriesListView(),
          PostBlocConsumer(),
        ],
      ),
    );
  }
}
