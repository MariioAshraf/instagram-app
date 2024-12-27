import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/core/di/dependency_injection.dart';
import 'package:instagram_app/features/post/domain/use_cases/post_use_case.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/create_post_view_body.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../home/presentation/views/widgets/gradient_background.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    final PostCubit postCubit = PostCubit.get(context);
    ;
    return ScaffoldGradientBackgroundContainer(
      child: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        backgroundColor: Colors.transparent,
        floatingActionButton: _buildPickImagesFloatingButton(context),
        body: SafeArea(
            child: BlocBuilder<PostCubit, PostState>(
          buildWhen: (_, current) =>
              current is CanNotUploadPost ||
              current is CanUploadPost ||
              current is PostFilesPickedSuccess,
          builder: (context, state) {
            return CreatePostViewBody(
              postCubit: postCubit,
            );
          },
        )),
      ),
    );
  }

  FloatingActionButton _buildPickImagesFloatingButton(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: () {
        PostCubit.get(context).pickPostFiles();
      },
      backgroundColor: AppColorsManager.mainBlue,
      child: const Icon(
        Icons.photo_library,
        size: 23,
        color: Colors.white,
      ),
    );
  }
}
