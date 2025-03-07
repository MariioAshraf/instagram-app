import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/widgets/build_user_profile_image.dart';
import '../../../../../core/utils/spacing.dart';

class PostUserImageAndNameRow extends StatelessWidget {
  const PostUserImageAndNameRow({
    super.key,
    required this.userImage,
    required this.userName,
    required this.createdAt,
  });

  final String userImage;
  final String userName;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          UserCircleProfileImage(
            radius: 30.r,
            imageUrl: userImage,
          ),
          horizontalSpacing(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    userName,
                    style: AppTextStyles.font16DarkBlueMedium,
                  ),
                  horizontalSpacing(4),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 18.r,
                  ),
                ],
              ),
              Text(
                _formatPostDate(createdAt),
                style: AppTextStyles.font12GreyRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatPostDate(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d";
    } else if (createdAt.year == now.year) {
      return DateFormat("MMM d").format(createdAt); // Example: Feb 8
    } else {
      return DateFormat("MMM d, yyyy")
          .format(createdAt); // Example: Feb 8, 2023
    }
  }
}
