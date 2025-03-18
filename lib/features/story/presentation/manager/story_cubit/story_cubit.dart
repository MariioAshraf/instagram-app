import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/auth/models/user_model.dart';
import 'package:instagram_app/features/story/data/models/story_model.dart';
import 'package:instagram_app/features/story/data/repos/story_repo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;

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
      _clearLists();
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
            // await createThumbnails(file.path, storiesList.indexOf(file));
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

  void _clearLists() {
    // storyThumbnailPathList.clear();
    storiesList.clear();
    textEditingControllersList.clear();
    videoPlayerControllerList.clear();
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
    result.fold((err) {
      emit(UploadStoriesFailure(errMsg: err.message));
    }, (r) => emit(UploadStoriesSuccess()));
  }

  List<StoryModel> myStories = [];

  Future<void> getMyStories(String userId) async {
    emit(GetMyStoriesLoading());
    var result = await storyRepo.getMyStories(userId: userId);
    result.fold((err) {
      emit(GetMyStoriesFailure(err.message));
    }, (r) {
      myStories = r;
      emit(GetMyStoriesSuccess());
    });
  }

  downloadStoryFile(StoryModel storyModel) async {
    emit(DownloadingStoryLoading());
    var result = await storyRepo.downloadStoryFile(storyModel);
    result.fold((err) {
      emit(DownloadingStoryFailure(errMsg: err.message));
    }, (storyModel) {
      emit(DownloadingStorySuccess(story: storyModel));
    });
  }

  Future<void> getFriendsStories(String userId) async {
    emit(GetFriendsStoriesLoading());
    var result = await storyRepo.getFriendsStories(userId);
    result.fold((err) {
      emit(GetFriendsStoriesFailure(err.message));
    }, (storiesMap) async {
      organizeStories(userId, storiesMap);
      // await storiesOwners();
      emit(GetFriendsStoriesSuccess());
    });
  }

  // List<String?> storyThumbnailPathList = [];
  //
  // Future<void> createThumbnails(String filePath, int index) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final thumbnailPath = path.join(directory.path, 'thumbnail_$index.jpg');
  //   storyThumbnailPathList[index] = await VideoThumbnail.thumbnailFile(
  //     video: filePath,
  //     thumbnailPath: thumbnailPath,
  //     imageFormat: ImageFormat.JPEG,
  //     maxHeight: 50,
  //     quality: 75,
  //   );
  // }

  /// to get stories owners if we don't need to store them in hive
  /// storing them in hive causes non updatable user data during 1 day (story life time)
  // final Map<String, UserModel> users = {};

  // Future<Map<String, UserModel>> storiesOwners() async {
  //   users.clear();
  //   atLeastOneStoryNotSeenMap.keys.map((key) async {
  //     var userDoc = await _usersCollection.doc(key).get();
  //     users[key] = UserModel.fromJson(userDoc.data());
  //   }).toList();
  //   return users;
  // }

  Map<String, List<StoryModel>> storiesMapAllSeenBefore = {};
  Map<String, List<StoryModel>> atLeastOneStoryNotSeenMap = {};
  List<String> storySeenBefore = [];

  void organizeStories(
    String userId,
    Map<String, List<StoryModel>> storiesMap,
  ) {
    storySeenBefore.clear();
    storiesMapAllSeenBefore.clear();
    atLeastOneStoryNotSeenMap.clear();

    for (var entry in storiesMap.entries) {
      final List<StoryModel> userStories = entry.value;
      final String storiesOwnerId = entry.key;
      bool allViewed = userStories.every((story) {
        if (story.seenStoryDate!.containsKey(userId)) {
          storySeenBefore.add(story.storyId);
        }
        return story.seenStoryDate!.containsKey(userId);
      });
      if (allViewed) {
        storiesMapAllSeenBefore[storiesOwnerId] = userStories;
        // print('all seen ${storiesMapSeenBefore[storiesOwnerId]}');
        // print(
        //     'all seen length ${storiesMapSeenBefore[storiesOwnerId]?.length}');
      } else {
        atLeastOneStoryNotSeenMap[storiesOwnerId] = userStories;
        // print('not seen ${atLeastOneStoryNotSeenMap[storiesOwnerId]}');
      }
    }
    emit(StoriesOrganized());
  }

  /// Variables for load story
  Timer? timer;
  Timer? tapTimer;
  bool isVideoInitialized = false;
  VideoPlayerController? videoController;
  late bool isImage;
  late Duration storyDuration;
  Duration defaultDuration = const Duration(seconds: 5);
  late Duration elapsedTime;
  bool isStoryLoading = false;

  /// for load story and download story file
  Future<void> loadOnlineStory(StoryModel storyModel, String userId) async {
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
      storyRepo.setStorySeen(storyModel, userId: userId);
      emit(LoadStorySuccess(story: storyModel));
    } catch (e) {
      emit(LoadStoryFailure(errMsg: e.toString()));
    }
  }

  void closeControllers() {
    cancelTimers();
    _disposeVideoController();
  }

  void cancelTimers() {
    timer?.cancel();
    tapTimer?.cancel();
  }

  void _disposeVideoController() {
    if (isVideoInitialized) {
      videoController?.pause();
      videoController?.dispose();
      isVideoInitialized = false;
    }
  }

  void pauseStory() {
    timer?.cancel();
    if (!isImage && videoController?.value.isPlaying == true) {
      videoController?.pause();
    }
  }

  void resumeStory() {
    if (isImage) {
      emit(StartTimer());
    } else if (videoController?.value.isInitialized == true &&
        !videoController!.value.isPlaying) {
      videoController?.play();
      emit(StartTimer());
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

  /// for triggering video player and story preview removal

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

  disposeControllers() {
    for (var controller in videoPlayerControllerList) {
      if (controller != null) {
        controller.dispose();
      }
    }
  }
}
