part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostFilesPickedSuccess extends PostState {}

final class PostFilesPickedFailure extends PostState {
  final String errMessage;

  PostFilesPickedFailure(this.errMessage);
}

final class CreatePostSuccess extends PostState {}

final class CreatePostFailure extends PostState {
  final String errMessage;

  CreatePostFailure(this.errMessage);
}

final class CanUploadPost extends PostState {}

final class CanNotUploadPost extends PostState {}
