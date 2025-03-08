import 'package:flutter/material.dart';
import 'package:instagram_app/features/post/presentation/manager/post_cubit.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/create_post_bloc_consumer.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../home/presentation/views/widgets/app_main_gradient_background_container.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMainGradientBackgroundContainer(
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartFloat,
          backgroundColor: Colors.transparent,
          floatingActionButton: _buildPickImagesFloatingButton(context),
          body: const CreatePostBlocConsumer(),
        ),
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
