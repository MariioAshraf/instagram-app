import 'package:flutter/material.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/what_is_in_your_head_text_button.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../auth/login/presentation/manager/login_cubit.dart';
import '../../../../auth/models/user_model.dart';

class HomeCreatePostUserImageAndTextRow extends StatelessWidget {
  const HomeCreatePostUserImageAndTextRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = LoginCubit.get(context).userModel;
    return Row(
      children: [
        horizontalSpacing(20),
        buildUserProfileImage(userModel),
        horizontalSpacing(10),
        const WhatIsInYourHeadTextButton(),
        // HomeCreatePostTextField()
      ],
    );
  }
}
