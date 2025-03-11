import 'package:flutter/material.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/what_is_in_your_head_text_button.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../manager/home_cubit.dart';

class HomeCreatePostUserImageAndTextRow extends StatelessWidget {
  const HomeCreatePostUserImageAndTextRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileImage = HomeCubit.get(context).userModel!.profileImageUrl;
    return Row(
      children: [
        horizontalSpacing(20),
        buildUserProfileImage(
          profileImage: profileImage!,
          context,
        ),
        horizontalSpacing(10),
        const WhatIsInYourHeadTextButton(),
        // HomeCreatePostTextField()
      ],
    );
  }
}
