import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/home/presentation/manager/home_cubit.dart';
import 'package:instagram_app/features/post/presentation/manager/create_post_cubit/create_post_cubit.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/post_media_college.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
import 'create_post_text_field.dart';
import 'create_post_top_bar.dart';

class CreatePostBlocConsumer extends StatelessWidget {
  const CreatePostBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final postCubit = CreatePostCubit.get(context);
    return BlocConsumer<CreatePostCubit, CreatePostState>(
      buildWhen: (_, current) =>
          current is CanNotUploadPost ||
          current is CanUploadPost ||
          current is PostFilesPickedSuccess,
      listener: (context, state) {
        if (state is CreatePostLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: AppColorsManager.mainBlue,
                strokeWidth: 2,
              ),
            ),
          );
        }
        if (state is CreatePostSuccess) {
          HomeCubit.get(context).homePostsMap[state.post.postId] = state.post;
          context.pop();
          context.pop();
        }
        if (state is CreatePostFailure) {
          context.pop();
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
                    context.pop();
                  },
                  child: Text(
                    'Got it',
                    style: AppTextStyles.font14DarkBlueMedium,
                  ),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            top: 40.h,
            right: 16.w,
            left: 16.w,
          ),
          child: Column(
            children: [
              const CreatePostTopBar(),
              const CreatePostTextField(),
              _buildPostCollege(postCubit.media),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildPostCollege(List<XFile>? media) {
  return media != null && media.isNotEmpty
      ? PhotoCollage(images: media)
      : const SizedBox.shrink();
}
