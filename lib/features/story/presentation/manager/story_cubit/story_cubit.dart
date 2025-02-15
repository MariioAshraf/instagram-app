import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());

  static StoryCubit get(BuildContext context) => BlocProvider.of(context);

  List<File> listFiles = [];

  List<TextEditingController> textEditingControllersList = [];

  List<VideoPlayerController?> videoPlayerControllerList = [];

  Future<void> pickStoryMedia() async {
    try {
      listFiles.clear();
      textEditingControllersList.clear();
      videoPlayerControllerList.clear();
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.media,
      );
      if (result != null) {
        listFiles = result.paths.map((path) => File(path!)).toList();
        textEditingControllersList = List.generate(
          listFiles.length,
          (_) => TextEditingController(),
        );
        for (var file in listFiles) {
          if (file.path.endsWith('.mp4') || file.path.endsWith('.mov')) {
            // await createThumbnails(file.path, listFiles.indexOf(file));
            final controller = VideoPlayerController.file(file);
            await controller.initialize();
            videoPlayerControllerList.add(controller);
          } else {
            videoPlayerControllerList.add(null);
          }
        }
        emit(StoryMediaPickedSuccess());
      }
    } catch (e) {
      emit(StoryMediaPickedFailure(errMsg: e.toString()));
    }
  }

  bool showPauseIcon = true;
  Timer? _hideIconTimer;

  void triggerVideoPlayer(int index) {
    final controller = videoPlayerControllerList[index];
    if (controller!.value.isPlaying) {
      controller.pause();
      showPauseIcon = false;
    } else {
      controller.play();
      showPauseIcon = true;
      _hideIconTimer?.cancel();
      _hideIconTimer = Timer(const Duration(seconds: 2), () {
        showPauseIcon = false;
        emit(TriggerVideoPlayerSuccess());
      });
    }
    emit(TriggerVideoPlayerSuccess());
  }

  void removeFile(int index) {
    textEditingControllersList[index].dispose();
    textEditingControllersList.removeAt(index);
    if (videoPlayerControllerList[index] != null) {
      videoPlayerControllerList[index]!.dispose();
    }
    videoPlayerControllerList.removeAt(index);
    listFiles.removeAt(index);
  }
}
