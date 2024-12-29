import 'package:flutter/material.dart';
import 'package:instagram_app/core/utils/spacing.dart';
import '../../../../../core/theming/app_styles.dart';

class UserNameAndBio extends StatelessWidget {
  const UserNameAndBio({super.key, required this.bio, required this.name});

  final String bio;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          '${name[0].toUpperCase()}${name.substring(1)}',
          style: AppTextStyles.font18DarkBlueBold.copyWith(fontSize: 28),
        ),
        verticalSpacing(6),
        Text(
          textAlign: TextAlign.center,
          bio.isNotEmpty ? bio : 'Write you Bio...',
          style: AppTextStyles.font13GreyRegular,
        ),
      ],
    );
  }
}
