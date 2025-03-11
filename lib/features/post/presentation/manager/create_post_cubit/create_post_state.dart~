part of 'create_post_cubit.dart';

@immutable
sealed class CreatePostState {}

final class PostInitial extends CreatePostState {}

final class PostFilesPickedSuccess extends CreatePostState {}

final class PostFilesPickedFailure extends CreatePostState {
  final String errMessage;

  PostFilesPickedFailure(this.errMessage);
}

final class CreatePostSuccess extends CreatePostState {
  final PostModel post;

  CreatePostSuccess(this.post);
}

final class CreatePostLoading extends CreatePostState {}

final class CreatePostFailure extends CreatePostState {
  final String errMessage;

  CreatePostFailure(this.errMessage);
}

final class CanUploadPost extends CreatePostState {}

final class CanNotUploadPost extends CreatePostState {}



