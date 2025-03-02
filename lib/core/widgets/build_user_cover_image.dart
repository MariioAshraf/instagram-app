import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/home/presentation/manager/home_cubit.dart';

Widget buildUserCoverImage(
  BuildContext context,
) {
  final userCoverImageUrl = HomeCubit.get(context).userModel.coverImageUrl!;
  final height = MediaQuery.of(context).size.height;
  return userCoverImageUrl.isNotEmpty
      ? Container(
          height: height * 0.27,
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(userCoverImageUrl),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
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
