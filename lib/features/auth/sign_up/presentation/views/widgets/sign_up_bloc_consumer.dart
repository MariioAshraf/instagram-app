import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../../../core/theming/app_styles.dart';
import '../../../../../../core/widgets/app_text_button.dart';
import '../../manager/sign_up_cubit.dart';
class SignUpBlocConsumer extends StatelessWidget {
  const SignUpBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signUpCubit = SignUpCubit.get(context);
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
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
                )
              ],
            ),
          );
        }
        if (state is SignUpSuccess) {
          _showSuccessMessage(context);
          context.pushReplacementNamed(Routes.loginView);
        }
      },
      builder: (context, state) {
        return AppTextButton(
          onPressed: () async {
            if (signUpCubit.formKey.currentState!.validate()) {
              await signUpCubit.signUp();
            }
          },
          childWidget: state is SignUpLoading
              ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.sp,
            ),
          )
              : Text(
            'Sign Up',
            style: AppTextStyles.font16WhiteSemiBold,
          ),
        );
      },
    );
  }
}

void _showSuccessMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Account created successfully',
        style: AppTextStyles.font14DarkBlueMedium,
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColorsManager.darkBlue,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
