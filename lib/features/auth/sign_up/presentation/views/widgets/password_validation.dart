import 'package:flutter/material.dart';

import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/app_styles.dart';


class PasswordValidation extends StatelessWidget {
  const PasswordValidation(
      {super.key,
      required this.hasLowerCase,
      required this.hasUpperCase,
      required this.hasSpecialCharacter,
      required this.hasNumber,
      required this.hasMinLength});

  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacter;
  final bool hasNumber;
  final bool hasMinLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        passwordValidationRow(
          text: ' At least 1 lowercase letter',
          hasValidated: hasLowerCase,
        ),
        passwordValidationRow(
          text: ' At least 1 uppercase letter',
          hasValidated: hasUpperCase,
        ),
        passwordValidationRow(
          text: ' At least 1 special character',
          hasValidated: hasSpecialCharacter,
        ),
        passwordValidationRow(
          text: ' At least 1 number',
          hasValidated: hasNumber,
        ),
        passwordValidationRow(
          text: ' At least 8 characters long',
          hasValidated: hasMinLength,
        ),
      ],
    );
  }
}

Widget passwordValidationRow({required String text, required bool hasValidated}) {
  return Row(
    children: [
      const CircleAvatar(
        radius: 2,
        backgroundColor: AppColorsManager.darkBlue,
      ),
      Text(
        text,
        style: AppTextStyles.font14DarkBlueMedium.copyWith(
          fontSize: 13,
          decoration: hasValidated ? TextDecoration.lineThrough : null,
          color: hasValidated ? Colors.grey : AppColorsManager.darkBlue,
          decorationColor: Colors.green,
          decorationThickness: 3,
        ),
      )
    ],
  );
}
