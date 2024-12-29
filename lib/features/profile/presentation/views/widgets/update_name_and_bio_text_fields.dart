import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import 'package:instagram_app/features/profile/presentation/manager/profile_cubit.dart';

class UpdateNameAndBioTextFields extends StatelessWidget {
  const UpdateNameAndBioTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = ProfileCubit.get(context);
    return Column(
      children: [
        TextFormField(
          controller: profileCubit.nameController,
          decoration: const InputDecoration(
            hintText: 'Update your Name',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        verticalSpacing(30),
        TextFormField(
          controller: profileCubit.bioController,
          decoration: const InputDecoration(
            hintText: 'Update your Bio',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
