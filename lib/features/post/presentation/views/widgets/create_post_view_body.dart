import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CreatePostViewBody extends StatelessWidget {
  const CreatePostViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: const Column(
        children: [
          Text('Create Post'),
        ],
      ),
    );
  }
}
