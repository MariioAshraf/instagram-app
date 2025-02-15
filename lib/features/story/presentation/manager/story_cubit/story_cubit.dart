import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/story/data/repos/story_repo.dart';
import 'package:video_player/video_player.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit(this.storyRepo) : super(StoryInitial());
  final StoryRepo storyRepo;

  static StoryCubit get(BuildContext context) => BlocProvider.of(context);

  List<File> storiesList = [];

  List<TextEditingController> textEditingControllersList = [];

  List<VideoPlayerController?> videoPlayerControllerList = [];

  Future<void> pickStoryMedia() async {
    try {
      storiesList.clear();
      textEditingControllersList.clear();
      videoPlayerControllerList.clear();
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.media,
      );
      if (result != null) {
        storiesList = result.paths.map((path) => File(path!)).toList();
        textEditingControllersList = List.generate(
          storiesList.length,
          (_) => TextEditingController(),
        );
        for (var file in storiesList) {
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

  Future<void> uploadStory({
    required UserModel userModel,
  }) async {
    emit(UploadStoriesLoading());
    List<String> captions = [];
    textEditingControllersList.map((textController) {
      captions.add(textController.text);
    }).toList();
    var result = await storyRepo.uploadStory(
      userModel: userModel,
      media: storiesList,
      captions: captions,
      videoPlayerControllerList: videoPlayerControllerList,
    );
    result.fold((l) {
      print('reeeeeeeeeeeeeeeeeeeee${l.message}');
      emit(UploadStoriesFailure(errMsg: l.message));
    }, (r) => emit(UploadStoriesSuccess()));
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
    storiesList.removeAt(index);
  }
}
