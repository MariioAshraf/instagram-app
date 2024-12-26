import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../auth/models/user_model.dart';
import '../../domain/use_cases/post_use_case.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.postUseCase) : super(PostInitial());
  final PostUseCase postUseCase;
 static PostCubit get(context) => BlocProvider.of(context);
  List<XFile>? media;

  Future<void> pickPostFiles() async {
    try {
      final ImagePicker picker = ImagePicker();

      final pickedMedia = await picker.pickMultipleMedia();

      if (pickedMedia.isNotEmpty) {
        media = pickedMedia;
        emit(PostFilesPickedSuccess());
      } else {
        emit(PostFilesPickedFailure('No media files were selected.'));
      }
    } catch (e) {
      emit(PostFilesPickedFailure(
          'An error occurred while picking media files.'));
    }
  }

  Future<void> createPost(UserModel userModel) async {
    var result = await postUseCase.call(userModel, media);
    result.fold((failure) => emit(CreatePostFailure(failure.message)), (r) {
      media = null;
      emit(CreatePostSuccess());
    });
  }

  TextEditingController postTitleController = TextEditingController();

  void checkPostStatus() {
    if (postTitleController.text.trim().isEmpty &&
        (media == null || media!.isEmpty)) {
      emit(CanNotUploadPost());
    } else {
      emit(CanUploadPost());
    }
  }
}
