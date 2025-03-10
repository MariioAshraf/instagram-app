import 'package:flutter/material.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import 'drawer_item_builder.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = HomeCubit.get(context).userModel;
    return Drawer(
      elevation: 0,
      backgroundColor: Colors.white.withAlpha(230),
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildUserProfileImage(
                  profileImage: user!.profileImageUrl!,
                  context,
                  radius: 38,
                ),
                Text(
                  '${user.name[0].toUpperCase()}${user.name.substring(1)}',
                  style: AppTextStyles.font18DarkBlueBold,
                ),
              ],
            ),
          ),
          const DrawerItemBuilder(),
        ],
      ),
    );
  }
}
