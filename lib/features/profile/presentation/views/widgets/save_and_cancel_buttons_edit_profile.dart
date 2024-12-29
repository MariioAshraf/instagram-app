import 'package:flutter/material.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/core/utils/spacing.dart';

import '../../../../../core/theming/app_styles.dart';

class SaveAndCancelButtonsEditProfile extends StatelessWidget {
  const SaveAndCancelButtonsEditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              overlayColor: const WidgetStatePropertyAll(Colors.grey),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(16))),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.zero,
              ),
            ),
            onPressed: () {},
            child: Text(
              'Cancel',
              style: AppTextStyles.font14DarkBlueMedium,
            ),
          ),
        ),
        horizontalSpacing(20),
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  const WidgetStatePropertyAll(AppColorsManager.mainBlue),
              overlayColor: const WidgetStatePropertyAll(Colors.black12),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.zero,
              ),
            ),
            onPressed: () {},
            child: Text(
              'Save',
              style: AppTextStyles.font16WhiteSemiBold,
            ),
          ),
        ),
      ],
    );
  }
}
