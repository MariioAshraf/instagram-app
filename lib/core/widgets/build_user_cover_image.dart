import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_app/features/home/presentation/views/widgets/image_shimmer_loading.dart';

Widget buildUserCoverImage(BuildContext context,
    {required String userCoverImageUrl}) {
  final height = MediaQuery.of(context).size.height;
  return userCoverImageUrl.isNotEmpty
      ? Container(
          height: height * 0.27,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            child: CachedNetworkImage(
              imageUrl: userCoverImageUrl,
              fit: BoxFit.fill,
              placeholder: (context, url) => const ImageShimmerLoading(),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error, color: Colors.red, size: 40),
              ),
            ),
          ),
        )
      : Container(
          height: height * 0.27,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
        );
}
