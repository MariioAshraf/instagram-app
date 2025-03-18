// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/theming/app_colors.dart';
// import '../manager/story_cubit/story_cubit.dart';
//
// class StoriesUploadingThumbnailsView extends StatelessWidget {
//   const StoriesUploadingThumbnailsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColorsManager.mainBlue,
//           title: const Text('Uploading Stories...'),
//         ),
//         body: const UploadStoriesLoadingListView());
//   }
// }
//
// class UploadStoriesLoadingListView extends StatelessWidget {
//   const UploadStoriesLoadingListView({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     StoryCubit storyCubit = StoryCubit.get(context);
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       itemCount: storyCubit.storyThumbnailPathList.length,
//       itemBuilder: (context, index) {
//         return storyCubit.storyThumbnailPathList[index] != null
//             ? CircleAvatar(
//                 backgroundColor: Colors.transparent,
//                 radius: 32,
//                 child: ClipOval(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Image.file(
//                         File(storyCubit.storyThumbnailPathList[index]!),
//                         fit: BoxFit.cover,
//                         width: 64,
//                         height: 64,
//                       ),
//                       const CircularProgressIndicator(
//                         color: Colors.cyan,
//                         strokeAlign: 6,
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             : CircleAvatar(
//                 radius: 32.r,
//                 child: ClipOval(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Image.file(
//                         File(storyCubit.storiesList[index].path),
//                         fit: BoxFit.cover,
//                         width: 64.w,
//                         height: 64.h,
//                       ),
//                       const CircularProgressIndicator(
//                         color: AppColorsManager.mainBlue,
//                         strokeAlign: 6,
//                       )
//                     ],
//                   ),
//                 ),
//               );
//       },
//     );
//   }
// }
