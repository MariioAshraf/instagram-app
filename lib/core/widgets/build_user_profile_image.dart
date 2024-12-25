import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/features/auth/user_model_extensions.dart';
import '../../features/auth/models/user_model.dart';
import '../../features/home/presentation/views/widgets/image_shimmer_loading.dart';

Widget buildUserProfileImage(UserModel userModel) {
  return userModel.hasProfileImage
      ? UserCircleProfileImage(imageUrl: userModel.profileImageUrl!)
      : const UserDefaultProfileCircleAvatar();
}

class UserCircleProfileImage extends StatelessWidget {
  const UserCircleProfileImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 28,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: 56,
          height: 56,
          placeholder: (context, url) => const ImageShimmerLoading(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class UserDefaultProfileCircleAvatar extends StatelessWidget {
  const UserDefaultProfileCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 28,
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        color: Colors.black,
      ),
    );
  }
}
