import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/save_and_cancel_buttons_edit_profile.dart';
import 'package:instagram_app/features/profile/presentation/views/widgets/update_name_and_bio_text_fields.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key});

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UserProfileAndCoverImages(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            children: [
              UpdateNameAndBioTextFields(nameController: nameController),
              verticalSpacing(50),
              const SaveAndCancelButtonsEditProfile()
            ],
          ),
        ),
      ],
    );
  }
}
