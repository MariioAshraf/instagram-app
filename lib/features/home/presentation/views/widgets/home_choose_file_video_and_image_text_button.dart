import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/core/theming/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/spacing.dart';

class HomeChooseFileVideoAndImageTextButton extends StatelessWidget {
  const HomeChooseFileVideoAndImageTextButton({
    super.key,
    required this.type,
    required this.icon,
    required this.onTap,
  });

  final String type;
  final IconData icon;
  final void Function() onTap;

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
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColorsManager.mainBlue,
            ),
            horizontalSpacing(7),
            Text(
              type,
              style: AppTextStyles.font14DarkBlueMedium,
            )
          ],
        ));
  }
}
