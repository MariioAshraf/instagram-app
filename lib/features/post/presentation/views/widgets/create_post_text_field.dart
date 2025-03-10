import 'package:flutter/material.dart';
import '../../manager/post_cubit.dart';

class CreatePostTextField extends StatefulWidget {
  const CreatePostTextField({
    super.key,
  });

  @override
  State<CreatePostTextField> createState() => _CreatePostTextFieldState();
}

class _CreatePostTextFieldState extends State<CreatePostTextField> {
  late PostCubit postCubit;

  late TextEditingController titleController;

  @override
  void initState() {
    postCubit = PostCubit.get(context);
    titleController = TextEditingController();
    postCubit.checkPostStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 8,
      controller: titleController,
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
