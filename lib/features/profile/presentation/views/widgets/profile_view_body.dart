import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/routing/routes.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/user_name_and_bio.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/user_profile_and_cover_images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../home/presentation/manager/home_cubit.dart';
import 'edit_profile_row.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key, required this.dueToRebuildIssue,
  });
final String dueToRebuildIssue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final UserModel userModel = HomeCubit.get(context).userModel!;
    return SingleChildScrollView(
      child: Column(
        children: [
          UserProfileAndCoverImages(
            size: size,
          ),
          verticalSpacing(10),
          UserNameAndBio(
            name: userModel.name,
            bio: userModel.bio!,
          ),
          verticalSpacing(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: InkWell(
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              onTap: () {
                context.pushNamed(Routes.editProfileView);
              },
              child: const EditProfileRow(),
            ),
          ),
          verticalSpacing(50),
        ],
      ),
    );
  }
}
