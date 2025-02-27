import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/profile/presentation/manager/profile_cubit.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/save_and_cancel_buttons_edit_profile.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/update_name_and_bio_text_fields.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/update_profile_bloc_listener.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/user_profile_and_cover_images.dart';
import '../../../../auth/login/presentation/manager/login_cubit.dart';
import '../../../../home/presentation/manager/home_cubit.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key, required this.size});

  final Size size;

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = ProfileCubit.get(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const UpdateProfileBlocListener(),
          Stack(
            children: [
              UserProfileAndCoverImages(
                size: widget.size,
              ),
              Positioned(
                right: widget.size.width * .36,
                bottom: 1,
                child: PickImageIconButton(
                  onPressed: () {
                    profileCubit.pickProfilePhoto();
                  },
                ),
              ),
              Positioned(
                right: 3,
                bottom: widget.size.height * 0.06,
                child: PickImageIconButton(
                  onPressed: () {
                    profileCubit.pickCoverPhoto();
                  },
                ),
              ),
            ],
          ),
          const ChangeImagesBlocListener(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: Column(
              children: [
                const UpdateNameAndBioTextFields(),
                verticalSpacing(50),
                const SaveAndCancelButtonsEditProfile()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PickImageIconButton extends StatelessWidget {
  const PickImageIconButton({
    required this.onPressed,
    super.key,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 22.r,
      child: CircleAvatar(
        radius: 20.r,
        backgroundColor: AppColorsManager.mainBlue,
        child: IconButton(
            color: Colors.white,
            onPressed: onPressed,
            icon: const Icon(Icons.edit)),
      ),
    );
  }
}

class ChangeImagesBlocListener extends StatelessWidget {
  const ChangeImagesBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String uId = HomeCubit.get(context).userModel.uId!;
    ProfileCubit profileCubit = ProfileCubit.get(context);
    return BlocListener<ProfileCubit, ProfileState>(
        child: const SizedBox.shrink(),
        listener: (context, state) {
          if (state is PickProfilePhotoSuccess) {
            profileCubit.uploadProfilePhoto(
              path: state.profilePath,
              uId: uId,
            );
          }
          if (state is PickCoverPhotoSuccess) {
            profileCubit.uploadCoverPhoto(
              path: state.profilePath,
              uId: uId,
            );
          }
        });
  }
}
