import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/features/post/domain/repos/post_repo.dart';
import '../../../../auth/models/user_model.dart';
import '../../../data/models/post_model.dart';
import '../../../domain/use_cases/create_post_use_case.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit(this.createPostUseCase, this.postRepo) : super(PostInitial());
  final CreatePostUseCase createPostUseCase;
  final PostRepo postRepo;

  static CreatePostCubit get(context) => BlocProvider.of(context);

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

  final TextEditingController postTitleController = TextEditingController();

  Future<void> createPost(UserModel userModel) async {
    emit(CreatePostLoading());
    var result = await createPostUseCase.call(
        userModel, media, postTitleController.text);
    result.fold((failure) {
      emit(CreatePostFailure(failure.message));
    }, (post) {
      media = null;
      emit(CreatePostSuccess(post));
    });
  }

  void checkPostStatus() {
    if (postTitleController.text.trim().isEmpty &&
        (media == null || media!.isEmpty)) {
      emit(CanNotUploadPost());
    } else {
      emit(CanUploadPost());
    }
  }

  @override
  Future<void> close() {
    postTitleController.dispose();
    return super.close();
  }
}
