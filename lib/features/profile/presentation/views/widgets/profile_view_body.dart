import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/profile_image_bloc_consumer.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/user_name_and_bio.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/build_user_cover_image.dart';
import '../../../../auth/login/presentation/manager/login_cubit.dart';
import 'edit_profile_row.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = LoginCubit.get(context).userModel;
    return SingleChildScrollView(
      child: Column(
        children: [
          const UserProfileAndCoverImages(),
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
                  widget.scaffoldKey.currentState!.openDrawer();
                },
                child: const EditProfileRow()),
          ),
          verticalSpacing(50),
        ],
      ),
    );
  }
}

class UserProfileAndCoverImages extends StatelessWidget {
  const UserProfileAndCoverImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserModel userModel = LoginCubit.get(context).userModel;
    return SizedBox(
      height: size.height * 0.32,
      width: size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          buildUserCoverImage(
            context,
            height: size.height,
          ),
          ProfileImageBlocConsumer(
            profileImageUrl: userModel.profileImageUrl!,
          ),
        ],
      ),
    );
  }
}
