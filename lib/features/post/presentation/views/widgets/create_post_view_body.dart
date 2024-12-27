import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_media_college.dart';
import 'create_post_text_field.dart';
import 'create_post_top_bar.dart';

class CreatePostViewBody extends StatefulWidget {
  const CreatePostViewBody({super.key, required this.postCubit});

  final PostCubit postCubit;

  @override
  State<CreatePostViewBody> createState() => _CreatePostViewBodyState();
}

class _CreatePostViewBodyState extends State<CreatePostViewBody> {
  @override
  void initState() {
    widget.postCubit.checkPostStatus();
    super.initState();
  }

  @override
  void dispose() {
    widget.postCubit.postTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 40.h,
        right: 16.w,
        left: 16.w,
      ),
      child: Column(
        children: [
          const CreatePostTopBar(),
          const CreatePostTextField(),
          _buildPostCollege(widget.postCubit.media),
        ],
      ),
    );
  }
}

Widget _buildPostCollege(List<XFile>? media) {
  return media != null && media.isNotEmpty
      ? PhotoCollage(images: media)
      : const SizedBox.shrink();
}
