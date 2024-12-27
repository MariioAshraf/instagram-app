import 'package:flutter/material.dart';

import '../../manager/post_cubit.dart';
class CreatePostTextField extends StatelessWidget {
  const CreatePostTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PostCubit postCubit = PostCubit.get(context);
    return TextFormField(
      maxLines: 8,
      controller: postCubit.postTitleController,
      onChanged: (value) {
        if (value.trim().length < 2 &&
            (postCubit.media == null || postCubit.media!.isEmpty)) {
          postCubit.checkPostStatus();
        }
      },
      decoration: const InputDecoration(
          hintText: 'What is in your mind...', border: InputBorder.none),
    );
  }
}