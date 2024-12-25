import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
class WhatIsInYourHeadTextButton extends StatelessWidget {
  const WhatIsInYourHeadTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        overlayColor: AppColorsManager.darkBlue,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () {},
      child: Text(
        'What\'s in your head?',
        style: AppTextStyles.font17GreyRegular,
      ),
    );
  }
}
