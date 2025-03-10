import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/widgets/build_user_cover_image.dart';
import 'package:instagram_app/core/widgets/build_user_profile_image.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/profile_image_bloc_consumer.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import '../../../../../core/theming/app_colors.dart';
import 'cover_image_bloc_consumer.dart';

class UserProfileAndCoverImages extends StatelessWidget {
  const UserProfileAndCoverImages({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final userModel = HomeCubit.get(context).userModel;
    final bool hasStories = StoryCubit.get(context).myStories.isNotEmpty;
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is GetUserSuccess,
      builder: (context, state) {
        return SizedBox(
          height: size.height * 0.32,
          width: size.width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              buildUserCoverImage(context,
                  userCoverImageUrl: userModel.coverImageUrl!),
              Positioned(
                bottom: 0,
                child: CircleAvatar(
                  radius: 69.r,
                  backgroundColor:
                      hasStories ? AppColorsManager.mainBlue : Colors.white,
                  child: buildUserProfileImage(
                    context,
                    profileImage: userModel.profileImageUrl!,
                    radius: 66.r,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class EditUserProfileAndCoverImages extends StatelessWidget {
  const EditUserProfileAndCoverImages({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final bool hasStories = StoryCubit.get(context).myStories.isNotEmpty;
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is GetUserSuccess,
      builder: (context, state) {
        return SizedBox(
          height: size.height * 0.32,
          width: size.width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CoverImageBlocConsumer(
                height: size.height,
              ),
              ProfileImageBlocConsumer(
                hasStories: hasStories,
              ),
            ],
          ),
        );
      },
    );
  }
}
