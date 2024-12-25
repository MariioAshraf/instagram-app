import 'package:flutter/material.dart';
import 'package:instagram_app/features/auth/user_model_extensions.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/user_circle_profile_image.dart';
import '../../../../../core/widgets/user_default_profile_circle_avatar.dart';
import '../../../../auth/login/presentation/manager/login_cubit.dart';
import '../../../../auth/models/user_model.dart';
import 'home_create_post_text_field.dart';

class HomeCreatePostUserImageAndTextFileRow extends StatelessWidget {
  const HomeCreatePostUserImageAndTextFileRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = LoginCubit.get(context).userModel;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        horizontalSpacing(20),
        userModel.hasProfileImage
            ? UserCircleProfileImage(imageUrl: userModel.profileImageUrl!)
            : const UserDefaultProfileCircleAvatar(),
        horizontalSpacing(10),
        const Expanded(
          child: HomeCreatePostTextField(),
        ),
      ],
    );
  }
}
