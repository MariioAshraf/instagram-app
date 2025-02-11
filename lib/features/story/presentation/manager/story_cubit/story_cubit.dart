import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());

  static StoryCubit get(BuildContext context) => BlocProvider.of(context);

  List<File> listFiles = [];

  List<TextEditingController> textEditingControllersList = [];

  List videoPlayerControllerList = [];

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
}
