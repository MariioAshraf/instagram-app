import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/sign_up/presentation/views/widgets/password_validation.dart';

import '../../../../../../core/helpers/app_regex.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/widgets/app_text_form_field.dart';
import '../../manager/sign_up_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isObscureText = true;

  late TextEditingController passwordController;

  @override
  void initState() {
    // passwordController = context.read<SignUpCubit>().passwordController;
    setUpPasswordController();
    super.initState();
  }

  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasMinLength = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;

  void setUpPasswordController() {
    passwordController.addListener(() {
      setState(() {
        hasLowerCase = AppRegex.hasLowerCase(passwordController.text);
        hasUpperCase = AppRegex.hasUpperCase(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
        hasSpecialCharacter =
            AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var signUpCubit = SignUpCubit.get(context);
    return Form(
      // key: signUpCubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextFormField(
            validator: (value) {
              if (value == null ||
                  value.isEmpty) {
                return 'please enter your name';
              }
            },
            // controller: signUpCubit.nameController,
            hintText: 'name',
          ),
          verticalSpacing(10),
          AppTextFormField(
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPhoneValid(value)) {
                return 'please enter a valid phone number';
              }
            },
            // controller: signUpCubit.phoneController,
            hintText: 'phone number',
          ),
          verticalSpacing(10),
          AppTextFormField(
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'please enter a valid email';
              }
            },
            // controller: signUpCubit.emailController,
            hintText: 'Email',
          ),
          verticalSpacing(10),
          AppTextFormField(
            validator: (value) {
              if (value == null || value.isEmpty
              // ||!AppRegex.isPasswordValid(value)
              ) {
                return 'please enter a valid password';
              }
            },
            controller: passwordController,
            obscureText: isObscureText,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              icon: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColorsManager.darkBlue,
              ),
            ),
            hintText: 'Password',
          ),
          verticalSpacing(10),
          AppTextFormField(
            validator: (value) {
              // if (passwordController.text != signUpCubit.confirmPasswordController.text
              // ) {
              //   return 'password doesn\'t match';
              // }
            },
            // controller: signUpCubit.confirmPasswordController,
            obscureText: isObscureText,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              icon: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColorsManager.darkBlue,
              ),
            ),
            hintText: 'confirm Password',
          ),
          verticalSpacing(20),
          PasswordValidation(
            hasLowerCase: hasLowerCase,
            hasUpperCase: hasUpperCase,
            hasSpecialCharacter: hasSpecialCharacter,
            hasNumber: hasNumber,
            hasMinLength: hasMinLength,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
