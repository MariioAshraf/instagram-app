import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/app_styles.dart';
import '../../manager/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      child: const SizedBox.shrink(),
      listener: (context, state) {
        if (state is LoginFailure) {
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
                    ))
              ],
            ),
          );
        }
        if (state is LoginSuccess) {
          context.pop();
          context.pushNamed(Routes.homeView);
        }
        if (state is LoginLoading) {
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
