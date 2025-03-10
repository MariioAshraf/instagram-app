import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/image_shimmer_loading.dart';
import 'package:instagram_app/features/profile/presentation/manager/profile_cubit.dart';
import '../../../../../core/widgets/build_user_cover_image.dart';

class CoverImageBlocConsumer extends StatelessWidget {
  const CoverImageBlocConsumer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      buildWhen: (_, current) =>
          current is UploadCoverPhotoSuccess ||
          current is UploadCoverPhotoFailure ||
          current is UploadCoverPhotoLoading,
      listener: (context, state) {
        if (state is UploadCoverPhotoFailure) {
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
      },
      builder: (context, state) {
        return state is UploadCoverPhotoLoading
            ? SizedBox(
                height: height * 0.27,
                child: const ImageShimmerLoading(),
              )
            : buildUserCoverImage(
                userCoverImageUrl:
                    HomeCubit.get(context).userModel.coverImageUrl!,
                context,
              );
      },
    );
  }
}
