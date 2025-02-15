import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/auth/login/presentation/manager/login_cubit.dart';

import '../../manager/story_cubit/story_cubit.dart';

class StoryCaptionAndUploadButton extends StatelessWidget {
  const StoryCaptionAndUploadButton({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final userModel = LoginCubit.get(context).userModel;
    final storyCubit = StoryCubit.get(context);
    return Positioned(
      right: 0,
      left: 0,
      bottom: 10.h,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: TextField(
          controller: storyCubit.storiesList.isNotEmpty
              ? storyCubit.textEditingControllersList[currentIndex]
              : null,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Write a caption',
            suffixIcon: IconButton(
              onPressed: () {
                storyCubit.uploadStory(userModel: userModel);
              },
              icon: const Icon(Icons.send, color: Colors.white),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
