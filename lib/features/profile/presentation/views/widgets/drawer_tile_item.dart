import 'package:flutter/material.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/home/presentation/manager/bottom_nav_cubit.dart';
import '../../../../../core/theming/app_styles.dart';

class DrawerTileItem extends StatelessWidget {
  const DrawerTileItem({super.key, required this.index});

  final int index;

  final List<Icon> icons = const [
    Icon(Icons.person, color: AppColorsManager.mainBlue),
    Icon(Icons.photo_library, color: AppColorsManager.mainBlue),
    Icon(Icons.logout_outlined, color: AppColorsManager.mainBlue),
  ];

  final List<String> titles = const [
    'Profile',
    'Photos/Videos',
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icons[index],
      title: Text(
        titles[index],
        style: AppTextStyles.font14DarkBlueMedium,
      ),
      trailing: IconButton(
          onPressed: () {
            _onPressed(index, context);
          },
          icon: const Icon(
            color: Colors.black,
            Icons.arrow_forward_ios_rounded,
            size: 18,
          )),
    );
  }
}

void Function()? _onPressed(int index, BuildContext context) {
  if (index == 0) {
    context.pop();
    BottomNavCubit.get(context).changeBottomNav(2);
  } else if (index == 1) {
    // Photos/Videos
  } else if (index == 2) {
    // Settings
  }
  return null;
}
