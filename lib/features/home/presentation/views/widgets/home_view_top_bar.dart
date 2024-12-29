import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/core/utils/assets.dart';

class HomeViewTopBar extends StatelessWidget {
  const HomeViewTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 5.w,
          right: 5.w,
          bottom: 20.h,
        ),
        child: Row(
          children: [
            SvgPicture.asset(AssetsData.homeTopBarLogo),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_sharp,
                color: AppColorsManager.darkBlue,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: AppColorsManager.darkBlue,
                size: 30,
              ),
            ),
            SvgPicture.asset(
              AssetsData.homeTopBarShareIcon,
              height: 30.h,
              width: 30.w,
            ),
          ],
        ),
      ),
    );
  }
}
