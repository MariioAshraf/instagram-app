// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:instagram_app/features/story/data/extensions/story_model_extension.dart';
// import 'package:video_player/video_player.dart';
// import '../../data/models/story_model.dart';
// import '../manager/story_cubit/story_cubit.dart';
//
// class DisplayOnlineStoryView extends StatefulWidget {
//   const DisplayOnlineStoryView({super.key, required this.stories});
//
//   final List<StoryModel> stories;
//
//   @override
//   State<DisplayOnlineStoryView> createState() => _DisplayOnlineStoryViewState();
// }
//
// class _DisplayOnlineStoryViewState extends State<DisplayOnlineStoryView> {
//   late StoryCubit storyCubit;
//   int currentIndex = 0;
//   bool _isPaused = false;
//
//   @override
//   void initState() {
//     super.initState();
//     storyCubit = StoryCubit.get(context);
//     _loadCurrentStory();
//   }
//
//   void _loadCurrentStory() async {
//     final story = widget.stories[currentIndex];
//     if (story.haslocalFilePath) {
//       await storyCubit.loadStory(story);
//     } else {
//       await storyCubit.downloadStoryFile(story);
//     }
//   }
//
//   @override
//   void dispose() {
//     storyCubit.getFriendsStories();
//     storyCubit.closeControllers();
//     super.dispose();
//   }
//
//   void _onNextStory() {
//     if (currentIndex < widget.stories.length - 1) {
//       if (widget.stories[currentIndex].mediaType == MediaType.video) {
//         storyCubit.videoController?.pause();
//         storyCubit.videoController?.dispose();
//       }
//       setState(() {
//         currentIndex++;
//       });
//       _loadCurrentStory();
//     }
//   }
//
//   void _onPreviousStory() {
//     if (currentIndex > 0) {
//       if (widget.stories[currentIndex].mediaType == MediaType.video) {
//         storyCubit.videoController?.pause();
//         storyCubit.videoController?.dispose();
//       }
//       setState(() {
//         currentIndex--;
//       });
//       _loadCurrentStory();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: BlocConsumer<StoryCubit, StoryState>(
//         buildWhen: (previous, current) =>
//         current is DownloadingStoryLoading ||
//             current is DownloadingStorySuccess ||
//             current is LoadStoryFailure ||
//             current is LoadStorySuccess,
//         listener: (context, state) async {
//           if (state is DownloadingStorySuccess) {
//             widget.stories[currentIndex] = state.story;
//             await storyCubit.loadStory(widget.stories[currentIndex]);
//           }
//         },
//         builder: (context, state) {
//           if (state is DownloadingStoryLoading) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.red,
//                 strokeWidth: .7,
//               ),
//             );
//           }
//           if (storyCubit.isStoryLoading) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//                 strokeWidth: .7,
//               ),
//             );
//           }
//           if (state is LoadStoryFailure) {
//             return const Center(
//               child: Icon(
//                 Icons.refresh,
//                 color: Colors.white,
//               ),
//             );
//           }
//           if (state is LoadStorySuccess) {
//             final story = state.story;
//             return GestureDetector(
//               onLongPress: () {
//                 _isPaused = true;
//                 storyCubit.pauseStory();
//               },
//               onLongPressUp: () {
//                 _isPaused = false;
//                 storyCubit.resumeStory();
//               },
//               onTapDown: (details) {
//                 // Timer()
//                 if (details.localPosition.dx <
//                     MediaQuery.of(context).size.width / 2) {
//                   _onPreviousStory();
//                 } else {
//                   _onNextStory();
//                 }
//               },
//               child: Stack(
//                 children: [
//                   _buildMediaContent(story),
//                   _buildProgressBars(),
//                   _buildCaption(story),
//                 ],
//               ),
//             );
//           } else {
//             print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
//             return const Center(
//               child: Text(
//                 "No Story Available",
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildMediaContent(StoryModel story) {
//     if (story.mediaType == MediaType.image) {
//       return Center(
//         child: Image.file(
//           File(story.localFilePath!),
//           fit: BoxFit.cover,
//           width: double.infinity,
//         ),
//       );
//     } else if (story.mediaType == MediaType.video &&
//         storyCubit.videoController != null) {
//       return Center(
//         child: AspectRatio(
//             aspectRatio: storyCubit.videoController!.value.aspectRatio,
//             child: VideoPlayer(storyCubit.videoController!)),
//       );
//     }
//     return const Center(
//       child: CircularProgressIndicator(
//         color: Colors.white,
//         strokeWidth: .7,
//       ),
//     );
//   }
//
//   Widget _buildProgressBars() {
//     return Positioned(
//       top: 50,
//       left: 16,
//       right: 16,
//       child: Row(
//         children: List.generate(widget.stories.length, (index) {
//           final progress = index < currentIndex
//               ? 1.0
//               : (index == currentIndex
//               ? (storyCubit.elapsedTime.inMicroseconds /
//               storyCubit.storyDuration.inMicroseconds)
//               .clamp(0.0, 1.0)
//               : 0.0);
//           return Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2),
//               child: LinearProgressIndicator(
//                 value: progress,
//                 backgroundColor: Colors.white.withOpacity(0.4),
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildCaption(StoryModel story) {
//     return Positioned(
//       bottom: 80,
//       left: 16,
//       right: 16,
//       child: Text(
//         story.caption,
//         style: const TextStyle(color: Colors.white, fontSize: 18),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }
