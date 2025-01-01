import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/theming/app_styles.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/profile/presentation/manager/profile_cubit.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../auth/login/presentation/manager/login_cubit.dart';

class UpdateProfileBlocListener extends StatelessWidget {
  const UpdateProfileBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = LoginCubit.get(context);
    return BlocListener<ProfileCubit, ProfileState>(
      child: const SizedBox.shrink(),
      listener: (context, state) {
        if (state is UpdateUserFailure) {
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
                  child:
                      Text('Got it', style: AppTextStyles.font14DarkBlueMedium),
                ),
              ],
            ),
          );
        }
        if (state is UploadProfilePhotoSuccess ||
            state is UploadCoverPhotoSuccess) {
          loginCubit.getUser();
        }
        if (state is UpdateUserSuccess) {
          loginCubit.getUser();
          context.pop();
          context.pop();
        }
        if (state is UpdateUserLoading) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: AppColorsManager.mainBlue,
              ),
            ),
          );
        }
      },
    );
  }
}
