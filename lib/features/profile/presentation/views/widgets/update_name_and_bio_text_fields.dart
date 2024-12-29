import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/spacing.dart';

class UpdateNameAndBioTextFields extends StatelessWidget {
  const UpdateNameAndBioTextFields({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'name is required';
            }
            return null;
          },
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Update your Name',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        verticalSpacing(30),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'name is required';
            }
            return null;
          },
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Update your Bio',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
