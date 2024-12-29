// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/theming/app_styles.dart';
// import '../../manager/profile_cubit.dart';
//
// class CoverImageBlocConsumer extends StatelessWidget {
//   const CoverImageBlocConsumer({super.key, });
//   @override
//   Widget build(BuildContext context) {
//     ProfileCubit profileCubit = ProfileCubit.get(context);
//     AuthCubit authCubit = AuthCubit.get(context);
//     return BlocConsumer<ProfileCubit, ProfileState>(
//       buildWhen: (previous, current) =>
//           current is CoverImageSuccess ||
//           current is CoverImageFailure ||
//           current is CoverImageLoading,
//       listener: (context, state) {
//         if (state is ProfileImageFailure) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               icon: const Icon(
//                 Icons.error,
//                 color: Colors.red,
//                 size: 32,
//               ),
//               content: Text(state.errMsg),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Got it',
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500)),
//                 )
//               ],
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         print('cover image rebuild');
//         return state is CoverImageLoading
//             ? SizedBox(height: 210.h, child: const ImageShimmerLoading())
//             : authCubit.userModel!.coverImageUrl != null &&
//                     authCubit.userModel!.coverImageUrl!.isNotEmpty
//                 ? Stack(
//                     children: [
//                       SizedBox(
//                         height: 200.h,
//                         width: MediaQuery.of(context).size.width,
//                         child: CachedNetworkImage(
//                           placeholder: (context, url) =>
//                               const ImageShimmerLoading(),
//                           imageUrl: authCubit.userModel!.coverImageUrl!,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: CircleAvatar(
//                           radius: 22,
//                           backgroundColor: Colors.white,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.grey[300],
//                             radius: 19,
//                             child: IconButton(
//                               onPressed: () async {
//                                 await profileCubit.pickCoverImage(
//                                     profileCubit, authCubit, context);
//                               },
//                               icon: const Icon(
//                                 Icons.camera_alt_rounded,
//                                 color: Colors.black,
//                                 size: 22,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : Container(
//                     color: Colors.grey[300],
//                     height: 200.h,
//                     width: MediaQuery.of(context).size.width, // Full width here
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 30.h),
//                       child: InkWell(
//                         onTap: () {
//                           profileCubit.pickCoverImage(
//                               profileCubit, authCubit, context);
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Icon(
//                               Icons.camera_alt_outlined,
//                               color: Colors.black,
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Text(
//                               'Add Cover Photo',
//                               style: AppTextStyles.font14DarkBlueMedium,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//       },
//     );
//   }
// }
