import 'package:flutter/material.dart';
import 'package:instagram_app/core/theming/app_colors.dart';
import 'package:instagram_app/core/utils/extensions.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/profile/presentation/manager/profile_cubit.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../home/presentation/manager/home_cubit.dart';

class SaveAndCancelButtonsEditProfile extends StatelessWidget {
  const SaveAndCancelButtonsEditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = HomeCubit.get(context).userModel!;
    final ProfileCubit profileCubit = ProfileCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              overlayColor: const WidgetStatePropertyAll(Colors.grey),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.zero,
              ),
            ),
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Cancel',
              style: AppTextStyles.font14DarkBlueMedium,
            ),
          ),
        ),
        horizontalSpacing(20),
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  const WidgetStatePropertyAll(AppColorsManager.mainBlue),
              overlayColor: const WidgetStatePropertyAll(Colors.black12),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.zero,
              ),
            ),
            onPressed: () async {
              await profileCubit.updateUserNameAndBio(
                name: profileCubit.nameController.text,
                bio: profileCubit.bioController.text,
                userModel: userModel,
              );
            },
            child: Text(
              'Save',
              style: AppTextStyles.font16WhiteSemiBold,
            ),
          ),
        ),
      ],
    );
  }
}
