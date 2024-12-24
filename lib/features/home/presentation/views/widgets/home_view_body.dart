import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_create_post_container.dart';
import 'home_view_top_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: const CustomScrollView(
        slivers: [
          HomeViewTopBar(),
          HomeCreatePostContainer(),
        ],
      ),
    );
  }
}
