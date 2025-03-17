import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/features/auth/user_model_extensions.dart';
import '../../../../../core/functions/hive_functions.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import '../../../../home/presentation/views/widgets/image_shimmer_loading.dart';
import '../../manager/profile_cubit.dart';

class ProfileImageBlocConsumer extends StatelessWidget {
  const ProfileImageBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userModel = HomeCubit.get(context).userModel!;
    return Positioned(
      bottom: 0,
      child: CircleAvatar(
        radius: 69.r,
        backgroundColor: Colors.white,
        child: BlocConsumer<ProfileCubit, ProfileState>(
          buildWhen: (_, current) =>
              current is UploadProfilePhotoSuccess ||
              current is UploadProfilePhotoFailure ||
              current is UploadProfilePhotoLoading,
          listener: (context, state) async {
            if (state is UploadProfilePhotoFailure) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 32,
                  ),
                  content: Text(state.errMessage),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Got it',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is UploadProfilePhotoSuccess) {
              await HiveFunctions.updateUser(
                  userModel.copyWith(profileImageUrl: state.profileImageUrl));
            }
          },
          builder: (context, state) {
            if (state is UploadProfilePhotoLoading) {
              return const ClipOval(child: ImageShimmerLoading());
            }
            if (state is UploadProfilePhotoSuccess) {
              return buildUserProfileImage(
                profileImage: state.profileImageUrl,
                context,
                radius: 66,
              );
            }
            return buildUserProfileImage(
              profileImage: userModel.profileImageUrl!,
              context,
              radius: 66,
            );
          },
        ),
      ),
    );
  }
}
