import 'package:flutter/material.dart';
import '../../manager/create_post_cubit/create_post_cubit.dart';

class CreatePostTextField extends StatefulWidget {
  const CreatePostTextField({
    super.key,
  });

  @override
  State<CreatePostTextField> createState() => _CreatePostTextFieldState();
}

class _CreatePostTextFieldState extends State<CreatePostTextField> {
  late CreatePostCubit postCubit;

  @override
  void initState() {
    postCubit = CreatePostCubit.get(context);
    postCubit.checkPostStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        hintText: 'What is in your mind...',
        border: InputBorder.none,
      ),
    );
  }
}
