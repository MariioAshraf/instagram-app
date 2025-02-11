import 'package:flutter/material.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../auth/login/presentation/manager/login_cubit.dart';
import 'drawer_item_builder.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = LoginCubit.get(context).userModel;
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
                  context,
                  radius: 38,
                ),
                Text(
                  userModel.name,
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
