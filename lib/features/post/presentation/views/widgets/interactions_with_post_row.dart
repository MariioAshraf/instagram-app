import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/utils/assets.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/app_icon_button.dart';

class InteractionsWithPostRow extends StatelessWidget {
  const InteractionsWithPostRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIconButton(
          child: Icon(
            size: 31.sp,
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
        const Text('1.2k'),
        horizontalSpacing(10),
        AppIconButton(
          onPressed: () {},
          child: Icon(
            size: 28.sp,
            Icons.mode_comment_outlined,
            color: Colors.black,
          ),
        ),
        const Text('1.2k'),
        horizontalSpacing(20),
        AppIconButton(
          onPressed: () {},
          splashColor: Colors.transparent,
          child: Image.asset(
            AssetsData.shareIcon,
            height: 20.sp,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.bookmark_border_rounded,
          color: Colors.black,
          size: 24.sp,
        ),
      ],
    );
  }
}
