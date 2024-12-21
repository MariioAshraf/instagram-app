import 'package:flutter/material.dart';

import '../../../../../../core/theming/app_styles.dart';
class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'By logging, you agree to our',
              style: AppTextStyles.font13GreyRegular,
            ),
            TextSpan(
              text: ' Terms & Conditions',
              style: AppTextStyles.font14DarkBlueMedium,
            ),
            TextSpan(
              text: ' and ',
              style: AppTextStyles.font13GreyRegular.copyWith(height: 1.5),
            ),
            TextSpan(
              text: ' Privacy Policy',
              style: AppTextStyles.font14DarkBlueMedium,
            ),
          ],
        ),
      ),
    );
  }
}