import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../home/presentation/views/widgets/image_shimmer_loading.dart';
import '../../manager/profile_cubit.dart';

class ProfileImageBlocConsumer extends StatelessWidget {
  const ProfileImageBlocConsumer({
    super.key,
    required this.radius,
  });

  final bool hasStories = false;

  // i've sent this radius to make the widget not const cause of rebuild issue
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: hasStories ? AppColorsManager.mainBlue : Colors.white,
        child: BlocConsumer<ProfileCubit, ProfileState>(
          buildWhen: (_, current) =>
              current is UploadProfilePhotoLoading ||
              current is UploadProfilePhotoSuccess ||
              current is UploadProfilePhotoFailure,
          listener: (context, state) {
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
                      child: const Text('Got it',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            return state is UploadProfilePhotoLoading
                ? const ImageShimmerLoading()
                : buildUserProfileImage(
                    context,
                    radius: 66,
                  );
          },
        ),
      ),
    );
  }
}
