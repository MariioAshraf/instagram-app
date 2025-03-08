import 'package:flutter/material.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/app_main_gradient_background_container.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/edit_profile_view_body.dart';
import '../../../../core/theming/app_styles.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppMainGradientBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
            style: AppTextStyles.font18DarkBlueBold,
          ),
        ),
        body: EditProfileViewBody(
          size: size,
        ),
      ),
    );
  }
}
