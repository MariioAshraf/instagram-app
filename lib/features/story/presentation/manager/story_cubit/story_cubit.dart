import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/story/data/models/story_model.dart';
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
      emit(UploadStoriesFailure(errMsg: l.message));
    }, (r) => emit(UploadStoriesSuccess()));
  }

  List<StoryModel> myStories = [];

  Future<void> getMyStories(String userId) async {
    emit(GetMyStoriesLoading());
    var result = await storyRepo.getMyStories(userId: userId);
    result.fold((l) {
      emit(GetMyStoriesFailure(l.message));
    }, (r) {
      myStories = r;
      emit(GetMyStoriesSuccess());
    });
  }

  Timer? timer;
  Timer? tapTimer;
  bool isVideoInitialized = false;
  late VideoPlayerController? videoController;
  late bool isImage;
  late Duration storyDuration;
  Duration defaultDuration = const Duration(seconds: 5);
  late Duration elapsedTime;
  late bool isStoryLoading;

  Future<void> loadStory(StoryModel storyModel) async {
    emit(LoadStoryLoading());
    isStoryLoading = true;
    try {
      isImage = storyModel.mediaType == MediaType.image;
      if (isVideoInitialized) {
        _disposeVideoController();
      }
      storyDuration = storyModel.duration != 0
          ? Duration(seconds: storyModel.duration)
          : defaultDuration;

      if (isImage) {
        elapsedTime = Duration.zero;
        emit(StartTimer());
      } else {
        await initializeVideoController(storyModel);
      }
      isStoryLoading = false;
      // setStorySeen(storyModel);
      emit(LoadStorySuccess(story: storyModel));
    } catch (e) {
      emit(LoadStoryFailure(errMsg: e.toString()));
    }
  }

  // setStorySeen(StoryModel storyModel) async {
  //   final docRef = await usersCollection
  //       .doc(storyModel.userId)
  //       .collection('stories')
  //       .doc(storyModel.storyId)
  //       .collection('viewers')
  //       .doc(userId)
  //       .get();
  //   if (!docRef.exists) {
  //     final viewedAt = DateTime.now().toIso8601String();
  //     await docRef.reference.set({'viewedAt': viewedAt});
  //     var box = Hive.box<StoryModel>(kStoryBox);
  //     StoryModel? story = box.get(storyModel.storyId);
  //     if (story != null && !story.viewersIds!.containsKey(userId)) {
  //       story.viewersIds![userId!] = viewedAt;
  //       await box.put(story.storyId, story);
  //     }
  //     print('story seen');
  //   }
  // }
  void _disposeVideoController() {
    if (isVideoInitialized) {
      videoController?.pause();
      videoController?.dispose();
      isVideoInitialized = false;
    }
  }

  Future<void> initializeVideoController(StoryModel storyModel) async {
    try {
      videoController =
          VideoPlayerController.file(File(storyModel.localFilePath!));
      await videoController?.initialize();
      isVideoInitialized = true;
      storyDuration = videoController?.value.duration ?? defaultDuration;
      videoController?.play();
      elapsedTime = Duration.zero;
      emit(VideoInitialized());
      emit(StartTimer());
    } catch (e) {
      isVideoInitialized = false;
      emit(LoadStoryFailure(
          errMsg: "Failed to initialize video: ${e.toString()}"));
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
    storiesList.removeAt(index);
  }
}
