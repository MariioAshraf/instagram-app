import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/story/presentation/views/widgets/stories_list_view_builder.dart';

class StoriesListView extends StatelessWidget {
  const StoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200.h,
        width: double.maxFinite,
        child: const StoriesListViewBuilder(),
      ),
    );
  }
}


