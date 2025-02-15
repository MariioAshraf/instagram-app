import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/story/presentation/manager/story_cubit/story_cubit.dart';
import 'package:video_player/video_player.dart';

class PreviewStoriesVideos extends StatelessWidget {
  const PreviewStoriesVideos({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final storyCubit = StoryCubit.get(context);
    final videoController = storyCubit.videoPlayerControllerList[index];
    return Center(
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: BlocBuilder<StoryCubit, StoryState>(
          buildWhen: (_, current) => current is TriggerVideoPlayerSuccess,
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(videoController),
                IconButton(
                  onPressed: () {
                    storyCubit.triggerVideoPlayer(index);
                  },
                  icon: videoController.value.isPlaying
                      ? storyCubit.showPauseIcon
                          ? const Icon(
                              Icons.pause,
                              size: 50,
                              color: Colors.white,
                            )
                          : const SizedBox.shrink()
                      : const Icon(
                          Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
