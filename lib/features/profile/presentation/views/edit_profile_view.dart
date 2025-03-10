import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/app_main_gradient_background_container.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/edit_profile_view_body.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theming/app_styles.dart';
import '../../data/repos/profile_repo_impl.dart';
import '../../domain/use_cases/profile_use_case.dart';
import '../manager/profile_cubit.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppMainGradientBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
            style: AppTextStyles.font18DarkBlueBold,
          ),
        ),
        body: BlocProvider(
          create: (context) => ProfileCubit(
            getIt.get<ProfileRepoImpl>(),
            getIt.get<ProfileUseCase>(),
          ),
          child: EditProfileViewBody(
            size: size,
          ),
        ),
      ),
    );
  }
}
