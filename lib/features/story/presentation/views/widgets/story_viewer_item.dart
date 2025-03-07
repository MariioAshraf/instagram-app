import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/features/auth/user_model_extensions.dart';
import 'package:intl/intl.dart';
import '../../../../auth/models/user_model.dart';
import '../../../../home/presentation/views/widgets/image_shimmer_loading.dart';

class StoryViewersItem extends StatelessWidget {
  const StoryViewersItem({super.key, required this.friend});

  final UserModel? friend;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (friend != null && friend!.hasProfileImage)
          ? CircleAvatar(
              backgroundColor: Colors.white,
              radius: 28,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: friend!.profileImageUrl!,
                  fit: BoxFit.cover,
                  width: 56,
                  height: 56,
                  placeholder: (context, url) => const ImageShimmerLoading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            )
          : const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey,
              child: ClipOval(
                  child: Icon(
                Icons.person,
                size: 35,
                color: Colors.black,
              )),
            ),
      title: Text(friend!.name),
      subtitle: Text(_formatViewedAt(friend!.viewStoryAt!)),
    );
  }

  String _formatViewedAt(
    String viewedAt,
  ) {
    final DateTime dateTimeViewedAt = DateTime.parse(viewedAt);
    final now = DateTime.now();
    final durationSinceViewed = now.difference(dateTimeViewedAt);

    if (durationSinceViewed.inHours < 24 && dateTimeViewedAt.day == now.day) {
      return "Today, ${DateFormat('hh:mm a').format(dateTimeViewedAt)}";
    } else if (durationSinceViewed.inHours < 24) {
      return "Yesterday, ${DateFormat('hh:mm a').format(dateTimeViewedAt)}";
    } else {
      return DateFormat('yyyy/MM/dd, hh:mm a').format(dateTimeViewedAt);
    }
  }
}
