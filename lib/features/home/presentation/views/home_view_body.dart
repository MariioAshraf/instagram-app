import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/core/utils/assets.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: HomeViewTopBar(),
    );
  }
}
class HomeViewTopBar extends StatelessWidget {
  const HomeViewTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AssetsData.homeTopBarLogo),
      ]
    );
  }
}
