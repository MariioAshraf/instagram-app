import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/create_post_view_body.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
class CreatePostBlocConsumer extends StatelessWidget {
  const CreatePostBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PostCubit postCubit = PostCubit.get(context);
    return BlocConsumer<PostCubit, PostState>(
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
      buildWhen: (_, current) =>
      current is CanNotUploadPost ||
          current is CanUploadPost ||
          current is PostFilesPickedSuccess,
      builder: (context, state) {
        return CreatePostViewBody(
          postCubit: postCubit,
        );
      },
    );
  }
}