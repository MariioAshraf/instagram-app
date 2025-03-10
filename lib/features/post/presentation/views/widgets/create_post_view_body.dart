import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/post/presentation/manager/create_post_cubit/create_post_cubit.dart';
import 'package:instagram_app/features/post/presentation/views/widgets/create_post_bloc_consumer.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../data/repos/post_repo_impl.dart';
import '../../../domain/use_cases/create_post_use_case.dart';

class CreatePostViewBody extends StatelessWidget {
  const CreatePostViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostCubit(
        getIt.get<CreatePostUseCase>(),
        getIt.get<PostRepoImpl>(),
      ),
      child: const CreatePostBlocConsumer(),
    );
  }
}
