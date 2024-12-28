import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/utils/spacing.dart';

class HomeCreatePostPickFilesRow extends StatelessWidget {
  const HomeCreatePostPickFilesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_photo_alternate,
              color: AppColorsManager.mainBlue,
            ),
            horizontalSpacing(7),
            Text(
              'Image',
              style: AppTextStyles.font14DarkBlueMedium,
            )
          ],
        )),
        VerticalDivider(
          indent: 23.h,
          endIndent: 23.h,
          thickness: 1.3,
          color: Colors.black,
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.movie,
              color: AppColorsManager.mainBlue,
            ),
            horizontalSpacing(7),
            Text(
              'Video',
              style: AppTextStyles.font14DarkBlueMedium,
            )
          ],
        )),
      ],
    );
  }
}
