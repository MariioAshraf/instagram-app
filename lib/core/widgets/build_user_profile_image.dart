import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/home/presentation/views/widgets/image_shimmer_loading.dart';

Widget buildUserProfileImage(
  BuildContext context, {
  double radius = 24,
  required String profileImage,
}) {
  return profileImage.isNotEmpty
      ? UserCircleProfileImage(
          imageUrl: profileImage,
          radius: radius,
        )
      : UserDefaultProfileCircleAvatar(
          radius: radius,
        );
}

class UserCircleProfileImage extends StatelessWidget {
  const UserCircleProfileImage(
      {super.key, required this.imageUrl, required this.radius});

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: radius.r,
      child: ClipOval(
        child: CachedNetworkImage(
          height: radius.r * 2,
          width: radius.r * 2,
          imageUrl: imageUrl,
          fit: BoxFit.fitHeight,
          useOldImageOnUrlChange: true,
          placeholder: (context, url) => const ImageShimmerLoading(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class UserDefaultProfileCircleAvatar extends StatelessWidget {
  const UserDefaultProfileCircleAvatar({super.key, required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: Colors.grey,
      child: const Icon(
        Icons.person,
        color: Colors.black,
      ),
    );
  }
}
